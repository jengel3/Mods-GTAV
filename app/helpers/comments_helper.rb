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
      comments.order('created_at DESC')
    when 'oldest'
      comments.order('created_at ASC')
    when 'creator'
      comments.where(:user => @submission.creator).order('created_at ASC')
    when 'admin'
      comments.where(:user_id.in => User.where(:admin => true).distinct(:_id)).order('created_at ASC')
    else
      comments.order('created_at ASC')
    end
  end
end
