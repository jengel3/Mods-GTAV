class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def like
    return render json: { :status => "not authenticated" } if !current_user
    @comment = Comment.find(params[:comment_id])
    return render json: { :status => "can not like own comment" } if current_user == @comment.user
    current_like = @comment.likes.where(:user => current_user).first
    if current_like
      current_like.destroy
      @comment.like_count -= 1
      @comment.save
      respond_to do |format|
        format.json { render json: { :status => 'removed like', :count => @comment.like_count }, status: 200 }
      end
    else
      @comment.likes.create(:user => current_user)
      @comment.like_count += 1
      @comment.save
      respond_to do |format|
        format.json { render json: { :status => 'liked comment', :count => @comment.like_count }, status: 200 }
      end
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @submission = Submission.find(params[:submission_id])
    @comment.submission = @submission
    @comment.user = current_user
    if @comment.save
      redirect_to @submission, notice: t('comments.commented_on', name: @submission.name)
    else
      redirect_to @submission, alert: t('comments.comment_failed')
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
