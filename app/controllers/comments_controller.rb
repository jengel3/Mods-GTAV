class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @submission = Submission.find(params[:submission_id])
    @comment.submission = @submission
    if @comment.save
      redirect_to @submission, notice: "Successfully commented on #{@submission.name}."
    else
      redirect_to @submission, alert: 'Failed to save your comment. Please try again.'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
