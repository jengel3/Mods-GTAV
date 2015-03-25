class Api::V1::CommentsController < Api::V1::BaseController
  include CommentsHelper
  def index
    @submission = Submission.find(params[:submission_id])
    @comments = comment_sort(@submission.comments.unscoped.all).page(params[:c_page]).per(10).reject(&:new_record?)
  
    serialized_comments = ActiveModel::ArraySerializer.new(@comments, each_serializer: CommentSerializer)

    respond_to do |format|
      format.json { render json: serialized_comments }
    end
  end

  def show
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.find(params[:id])
    respond_to do |format|
      format.json { render json: @comment }
    end
  end

  def create
  end

  def destroy
  end
end
