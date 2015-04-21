namespace :dev do

  task :test_pluck => :environment do
    n = 1000
    Benchmark.bm do |x|
      x.report {
        n.times do
          topic_ids = Topic.where( :user_id => 6 ).map{ |t| t.id }
          comments = Comment.where( :topic_id => topic_ids )
        end
      }

      x.report {
        n.times do
          topic_ids = Topic.where( :user_id => 6 ).pluck(:id)
          comments = Comment.where( :topic_id => topic_ids )
        end
      }

      x.report {
        n.times do
          Comment.joins(:topic).where( "topics.user_id" => 6)
        end
      }
    end

  end

  task :fake => :environment do
    puts "Fake data..."

    User.delete_all
    Topic.delete_all
    Comment.delete_all

    users = []
    emails = ["ihower@gmail.com", "frozenfung@gmail.com", "vneverz@gmail.com", "tim.du@alphacamp.co"]
    emails.each do |email|
      users << User.create( :email => email, :password => "12345678")
    end

    100.times do |i|
      puts "Generate topic #{i}"
      t = Topic.create( :title => Faker::Lorem.word, :content => Faker::Lorem.paragraph, :user => users.sample )

      10.times do |j|
        puts "  Generate comment #{j}"
        t.comments.create( :content => Faker::Lorem.paragraph, :user => users.sample )
      end
    end

  end

end