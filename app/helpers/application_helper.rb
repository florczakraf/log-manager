module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''
    
    content_tag(:li, class: class_name) do
      link_to link_text, link_path
    end
  end

  def bootstrap_alert_class(alert)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[alert.to_sym] || alert.to_s
  end

  def colorize_guid(guid)
    "#{guid[0...-8]}<span class='bg-info'>#{guid[-8..-1]}</span>".html_safe
  end
end
