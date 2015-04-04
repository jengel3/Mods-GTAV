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

  def top_submissions
    key = "STAT:top_weekly_submissions"
    result = REDIS.get(key)
    if !result
      result = Array.new
      sort = { "$sort" => { count: -1 } }
      limit = {"$limit" => 5}
      group = { "$group" =>
        { "_id" => "$submission_id", "count" => { "$sum" => 1 } }
      }
      records = Download.weekly.collection.aggregate([group, sort, limit])
      records.each { |r| result << {submission: r['_id'].to_s, downloads: r['count']} }
      result = result.to_json
      REDIS.set(key, result)
      REDIS.expire(key, 12.hours)

    end
    json = JSON.parse(result)
    submissions = json.map { |x| x['submission'] }
    order = {}
    submissions.each_with_index { |s, i| order[s] = i}
    return Submission.find(submissions).sort_by { |sub| order[sub.id.to_s] }
  end

  def top_developers
    key = "STAT:top_weekly_developers"
    result = REDIS.get(key)
    if !result
      result = Array.new
      sort = { "$sort" => { count: -1 } }
      limit = {"$limit" => 5}
      group = { "$group" =>
        { "_id" => "$creator_id", "count" => { "$sum" => 1 } }
      }
      records = Download.weekly.collection.aggregate([group, sort, limit])
      records.each { |r| result << {user: r['_id'].to_s, downloads: r['count']} }
      result = result.to_json
      REDIS.set(key, result)
      REDIS.expire(key, 36.hours)
    end
    json = JSON.parse(result)
    users = json.map { |x| x['user'] }
    order = {}
    users.each_with_index { |s, i| order[s] = i}
    return User.find(users).sort_by { |user| order[user.id.to_s] }
  end

  def slider
    key = "STAT:slider"
    result = REDIS.get(key)
    if !result
      new_popular = Submission.valid.in(id: Submission.valid.where(:approved_at.gte => Date.today - 24.hours).where(:total_downloads.gte => 20).distinct(:id).sample(2))
      veteran = Submission.valid.in(id: Submission.valid.where(:approved_at.lt => Date.today - 48.hours).where(:total_downloads.gte => 1000).distinct(:id).sample(2))
      randoms = Submission.valid.in(id: Submission.valid.distinct(:id).sample(2))
      result = Submission.or(veteran.selector, randoms.selector, new_popular.selector).limit(6)
      if !result.any?
        return []
      end
      result = result.to_json(:only => [:name], :methods => [:cached_image, :slug])
      REDIS.set(key, result)
      REDIS.expire(key, 12.hours)
    end
    return JSON.parse(result)
  end

  def favorites
    Submission.where(:favorited_at.exists => true).desc(:favorited_at).limit(3)
  end
end
