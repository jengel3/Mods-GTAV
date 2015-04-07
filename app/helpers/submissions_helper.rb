module SubmissionsHelper
  def rating_text(submission)
    type = submission.avg_rating < 0 ? 'dislike' : 'like'
    type += 's' if submission.avg_rating.abs == 1
    submission.avg_rating.abs.to_s + ' ' + 'person'.pluralize(submission.avg_rating.abs) + ' ' + type + ' this mod.'
  end

  def active_cat(category)
    category == params[:category] || (params[:controller] == 'home' && category == 'home') ? 'active_menu_item' : ''
  end

  def active_sub(subcategory)
    param = params[:subcategory]
    if param && param != 'all'
      param.humanize.titleize == subcategory ? 'active_subcategory' : ''
    elsif (!param || param == 'all') && subcategory == 'all'
      'active_subcategory'
    end
  end

  def top_developers(time_period = DateTime.now - 1.week)
    User.all.joins(:submissions => :downloads).where('downloads.created_at >= ?', time_period).group("users.id").order("count(users.id) DESC").limit(6).count
  end

  def favorites
    Submission.where.not(:last_favorited => nil).order('last_favorited DESC').limit(3)
  end

  def top_submissions(time_period = DateTime.now - 1.week)
    Submission.all.joins(:downloads).where('downloads.created_at >= ?', time_period).group('submissions.id').order("count(submissions.id) DESC").limit(6).count    
  end

  def top_downloads(time_period = DateTime.now - 1.week, count = 3)
    Submission.all.joins(:downloads).where('downloads.created_at >= ?', time_period).group('submissions.id').order("count(submissions.id) DESC").limit(count)
  end


  def top_likes(time_period = DateTime.now - 1.week, count = 3)
    Submission.all.joins(:likes).where('likes.created_at >= ?', time_period).group('submissions.id').order("count(submissions.id) DESC").limit(count)
  end

  def featured(min = 100, time_period = DateTime.now - 1.week)
    Submission.all.joins(:downloads).where('downloads.created_at >= ?', time_period).group('submissions.id').having('count(submissions.id) > ?', min).order("RANDOM()").limit(6)
  end
end
