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

  nil
end
