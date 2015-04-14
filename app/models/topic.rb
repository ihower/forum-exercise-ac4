class Topic < ActiveRecord::Base

  validates_presence_of :title, :content, :user_id

  belongs_to :user
  has_many :comments

  has_many :topic_categories
  has_many :categories, :through => :topic_categories

  def authors
    arr = self.comments.map{ |c| c.user }
    arr << self.user
    arr.uniq
  end

  def author_name
    user.try(:display_name) || "Nobody"
  end

end
