class Comment < ActiveRecord::Base

  validates_presence_of :content, :user_id

  belongs_to :user
  belongs_to :topic, :counter_cache => true # comments_count

  def author_name
    user.try(:display_name) || "Nobody"
  end

  def can_delete_by?(u)
    ( self.user == u ) || (u && u.is_admin?)
  end

end
