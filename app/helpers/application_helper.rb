module ApplicationHelper

  def user_avatar(user)
    link_to image_tag(user.gavatar_url, :class => "media-object", :width => "64", :alt => "user avatar"), user_path(user)
  end

end
