class Topic < ActiveRecord::Base

  validates_presence_of :title, :content, :user_id

  belongs_to :user
  has_many :comments

  def author_name
    user.try(:display_name) || "Nobody"
  end

end
