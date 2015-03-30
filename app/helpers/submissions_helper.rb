module SubmissionsHelper
  def rating_text(submission)
    type = submission.avg_rating < 0 ? 'dislike' : 'like'
    type += 's' if submission.avg_rating.abs == 1
    submission.avg_rating.abs.to_s + ' ' + 'person'.pluralize(submission.avg_rating.abs) + ' ' + type + ' this mod.'
  end
end
