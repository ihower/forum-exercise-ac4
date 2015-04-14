namespace :dev do

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