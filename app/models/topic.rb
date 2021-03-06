class Topic < ActiveRecord::Base

  validates_presence_of :title, :content, :user_id

  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :topic_categories
  has_many :categories, :through => :topic_categories

  def self.only_published(user)
    if user
      where( ["status = ? OR ( status = ? AND user_id = ? )", "published", "draft", user.id ] )
    else
      where( :status => "published" )
    end
  end

  def view!
    self.increment!(:views_count)
  end

  def authors
    arr = self.comments.map{ |c| c.user }
    arr << self.user
    arr.uniq
  end

  def author_name
    user.try(:display_name) || "Nobody"
  end

  def can_delete_by?(u)
    ( self.user == u ) || (u && u.is_admin?)
  end

end
