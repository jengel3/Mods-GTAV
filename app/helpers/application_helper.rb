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

  def bake_markdown(text)
    html = Kramdown::Document.new(text.gsub(/\n\r/,"<br/>")).to_html
    sanitized = Sanitize.fragment(html, :elements => @@elems)
    return sanitized
  end
end
