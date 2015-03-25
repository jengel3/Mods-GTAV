module CommentsHelper
  def comment_sort(comments, param=params[:c_sort])
    sort = param
    if sort
      sort = sort.downcase
    else
      sort = 'oldest'
    end
    case sort
    when 'newest'
      comments.desc('created_at')
    when 'oldest'
      comments.asc('created_at')
    when 'creator'
      comments.where(:user => @submission.creator).asc('created_at')
    when 'admin'
      comments.where(:user_id.in => User.where(:admin => true).distinct(:_id)).asc('created_at')
    else
      comments.asc('created_at')
    end
  end
end
