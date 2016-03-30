module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def short_current_user
   @short_current_user ||= User.find(session[:user_id]).name if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def full_title(page_title = '')
    base_title      = "Too Many Miles"
    extension_title = "Always Apply at the Right Time"
    if page_title.empty?
      base_title + " - " + extension_title
    else
      page_title + " | " + base_title
    end
  end

  def meta_description(full_meta_description)
    base_description = "Too Many Miles - Apply at the Right Time"
    if full_meta_description.empty?
      base_description
    else
      full_meta_description
    end
  end

  def no_follow_description(full_no_follow_description)
    if full_meta_description.empty?
    else
      full_meta_description
    end
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", errors: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def bootstrap_icon_for flash_type
    { success: "ok", errors: "remove-circle", alert: "warning-sign", notice: "exclamation-sign" }[flash_type.to_sym] || "question-sign"
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, '', class: "close", data: { dismiss: 'alert' })
        concat message
        end)
      end
    nil
  end


end
