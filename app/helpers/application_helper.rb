module ApplicationHelper
  def relative(time)
    time_ago_in_words(time) + ' ago'
  end
end
