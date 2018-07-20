module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: 'success',
      error: 'danger',
      alert: 'warning',
      notice: 'info'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(
        content_tag(
          :div,
          message,
          class: "alert alert-dismissible fade show alert-#{bootstrap_class_for(msg_type)}",
          role: 'alert'
        ) do
          concat content_tag(
            :button,
            'x',
            class: 'close',
            data: { dismiss: 'alert' }
          )
          concat message
        end
      )
    end
  end

  def gravatar_for(user:, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_size = size
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{gravatar_size}&d=404"
    image_tag(gravatar_url, alt: user.username, class: "img-circle elevation-2")
  end
  def adorable_avatar_for(user:, size: 80)
    adorable_id = user.username.downcase
    adorable_size = size
    adorable_url = "https://api.adorable.io/avatars/#{adorable_size}/#{adorable_id}.png"
    image_tag(adorable_url, alt: user.username, class: "img-circle elevation-2")
  end
  #
  # def controller_javascript(opts = {})
  #   if Rails.application.assets.find_asset("controllers/#{controller_name}.js")
  #     javascript_include_tag("controllers/#{controller_name}", opts)
  #   end
  # end
end
