# /api/v1
class Api::V1::CommentsController < Api::V1::BaseController
  include CommentsHelper
  def index
    @submission = Submission.find(params[:submission_id])
    @comments = comment_sort(@submission.comments).page(params[:c_page]).per(10).reject(&:new_record?)

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
    @submission = Submission.find(params[:submission_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.submission = @submission
    if @comment.save
      respond_to do |format|
        format.json { render json: {:status => 'success'}, status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @user == @comment.user || @user.admin
      @comment.destroy
      respond_to do |format|
        format.json { render json: {:status => 'success'}, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: {:status => 'not permitted'}, status: 401 }
      end
    end
  end

  private
  def comment_params
    params.permit(:text)
  end
end
