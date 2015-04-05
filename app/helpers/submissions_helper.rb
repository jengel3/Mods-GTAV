module SubmissionsHelper
  def rating_text(submission)
    type = submission.avg_rating < 0 ? 'dislike' : 'like'
    type += 's' if submission.avg_rating.abs == 1
    submission.avg_rating.abs.to_s + ' ' + 'person'.pluralize(submission.avg_rating.abs) + ' ' + type + ' this mod.'
  end

  def active_cat(category)
    category == params[:category] || (params[:action] == 'home' && category == 'home') ? 'active_menu_item' : ''
  end

  def active_sub(subcategory)
    param = params[:subcategory]
    if param && param != 'all'
      param.humanize.titleize == subcategory ? 'active_subcategory' : ''
    elsif (!param || param == 'all') && subcategory == 'all'
      'active_subcategory'
    end
  end

  def favorites
    Submission.where(:favorited_at.exists => true).order('favorited_at DESC').limit(3)
  end
end
