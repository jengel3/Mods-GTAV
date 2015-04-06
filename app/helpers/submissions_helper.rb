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

  def top_developers
    developers = User.all.joins(:submissions => :downloads).where('downloads.created_at >= ?', DateTime.now - 1.week).group("users.id").order("count(users.id) DESC").limit(6).count
    developers
  end

  def favorites
    favorites = Submission.where('favorited_at IS NOT NULL').limit(3)
    favorites
  end

  def top_submissions
    submissions = Submission.all.joins(:downloads).where('downloads.created_at >= ?', DateTime.now - 1.week).group('submissions.id').order("count(submissions.id) DESC")
    submissions
  end
end
