require 'kramdown'
require 'sanitize'
module SubmissionsHelper
  @@elems = ['b', 'i', 'a', 'del', 'em', 'br', 'strong']
  def rating_text(submission)
    type = submission.avg_rating < 0 ? 'dislike' : 'like'
    type += 's' if submission.avg_rating.abs == 1
    submission.avg_rating.abs.to_s + ' ' + 'person'.pluralize(submission.avg_rating.abs) + ' ' + type + ' this mod.'
  end

  def bake_markdown(text)
    html = Kramdown::Document.new(text.gsub(/\n\r/,"<br/>")).to_html
    sanitized = Sanitize.fragment(html, :elements => @@elems)
    return sanitized
  end
end
