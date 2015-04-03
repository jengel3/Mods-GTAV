module AvatarHelper
  require 'cgi'

  def avatar(user, options = {})
    image = user.avatar? ? user.avatar : 'michaelavatar.png'
    image_tag image, :alt => "Avatar", class: 'avatar'
  end
end