class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :topic

  def author_name
    user.try(:display_name) || "Nobody"
  end

end
