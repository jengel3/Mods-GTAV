require 'kramdown'
require 'sanitize'
module ApplicationHelper
  @@elems = ['b', 'i', 'a', 'del', 'em', 'br', 'strong']
  def relative(time)
    time_ago_in_words(time) + " ago"
  end

  def exact(time)
    time.strftime("%B #{time.day.ordinalize}, %Y - %l:%M %p")
  end

  def short(time)
    time.strftime("%B #{time.day.ordinalize}, %Y")
  end

  def active_cat(category)
    category == params[:category] || (params[:controller] == 'home' && category == 'home') || (@submission && @submission.category == category) ? 'active_menu_item' : ''
  end

  def active_sub(subcategory)
    param = params[:subcategory]
    if param && param != 'all'
      param.humanize.titleize == subcategory ? 'active_subcategory' : ''
    elsif (!param || param == 'all') && subcategory == 'all'
      'active_subcategory'
    end
  end

  def get_request_ip
    request.headers['X-Forwarded-For'] || request.ip
  end
end
