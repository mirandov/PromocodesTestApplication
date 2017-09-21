module ApplicationHelper
  def lnil(date)
    date.nil? ? 'не указано' : l(date)
  end
  
  def breadcrumb_tag(&block)
    render 'application/breadcrumb', block: capture(&block)
  end
end
