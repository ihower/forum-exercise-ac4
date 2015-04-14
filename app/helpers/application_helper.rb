module ApplicationHelper

  def user_avatar(user)
    image_tag user.gavatar_url, :class => "media-object", :width => "64", :alt => "user avatar"
  end

end
