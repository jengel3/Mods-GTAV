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
    key = 'STAT:TOP_DEVS'
    result = REDIS.get(key)
    if !result
      users = User.all.joins(:submissions => :downloads).where('downloads.created_at >= ?', time_period).group("users.id").order("count(users.id) DESC").limit(6).count

      result = {}
      users.each do |u, c|
        result[User.find(u).username] = c
      end
      result = result.to_json
      REDIS.set(key, result)
      REDIS.expire(key, 24.hours)
    end
    return JSON.load(result)
  end

  def top_submissions(time_period = DateTime.now - 1.week)
    key = 'STAT:TOP_DEVS'
    result = REDIS.get(key)
    if !result
      submissions = Submission.all.joins(:downloads).where('downloads.created_at >= ?', time_period).group('submissions.id').order("count(submissions.id) DESC").limit(6).count    

      result = {}
      submissions.each do |u, c|
        submission = Submission.find(u)
        result[submission.name] = {:downloads => c, :path => submission.path}
      end
      result = result.to_json
      REDIS.set(key, result)
      REDIS.expire(key, 24.hours)
    end
    return JSON.load(result)
  
  end

  def favorites
    Submission.where.not(:last_favorited => nil).order('last_favorited DESC').limit(3)
  end

  # helper method, do not use raw
  def top_downloads(time_period = DateTime.now - 1.week, count = 3)
    Submission.all.joins(:downloads).where('downloads.created_at >= ?', time_period).group('submissions.id').order("count(submissions.id) DESC").limit(count)
  end

  def trending_now
    key = "STAT:TODAY"
    result = REDIS.get(key)
    if !result
      submissions = top_downloads(DateTime.now - 12.hours)
      result = submissions.to_json(:only => [:name, :avg_rating, :download_count, :updated_at], :methods => [:path, :fetch_creator, :fetch_display])
      REDIS.set(key, result)
      REDIS.expire(key, 12.hours)
    end
    return JSON.load(result)
  end

  def today_downloads
    key = "STAT:TODAY"
    result = REDIS.get(key)
    if !result
      submissions = top_downloads(DateTime.now - 24.hours)
      result = submissions.to_json(:only => [:name, :avg_rating, :download_count, :updated_at], :methods => [:path, :fetch_creator, :fetch_display])
      REDIS.set(key, result)
      REDIS.expire(key, 12.hours)
    end
    return JSON.load(result)
  end


  def top_likes(time_period = DateTime.now - 1.week, count = 3)
    key = "STAT:LIKES:#{count}"
    result = REDIS.get(key)
    if !result
      submissions = Submission.all.joins(:likes).where('likes.created_at >= ?', time_period).group('submissions.id').order("count(submissions.id) DESC").limit(count)
      result = submissions.to_json(:only => [:name, :avg_rating, :download_count, :updated_at], :methods => [:path, :fetch_creator, :fetch_display])
      REDIS.set(key, result)
      REDIS.expire(key, 12.hours)
    end
    return JSON.load(result)
  end

  def featured(min = 100, time_period = DateTime.now - 1.week, num = 1)
    key = "STAT:FEATURED:#{num}:#{min}"
    result = REDIS.get(key)
    if !result
      submissions = Submission.all.joins(:downloads).where('downloads.created_at >= ?', time_period).group('submissions.id').having('count(submissions.id) > ?', min).order("RANDOM()").limit(6)
      result = submissions.to_json(:only => [:name, :avg_rating, :download_count], :methods => [:path, :fetch_creator, :fetch_display])
      REDIS.set(key, result)
      REDIS.expire(key, 12.hours)
    end
    return JSON.load(result)
  end
end
