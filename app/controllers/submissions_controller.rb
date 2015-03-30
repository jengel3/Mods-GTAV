class SubmissionsController < ApplicationController
  include CommentsHelper
  before_filter :set_submission, only: [:destroy, :edit, :update]
  before_filter :authenticate_user!, only: [:destroy, :edit, :create, :new, :update]

  def index
    @submissions = Submission.all
  end

  def show
    @submission = Submission.includes(:images).find(params[:id])
    @sort_options = {
      'Oldest First' => 'oldest',
      'Newest First' => 'newest',
      'Most Liked' => 'liked',
      'Creator Only' => 'creator',
      'Admin Only' => 'admin'
    }
    @sort = params[:c_sort] ||= session['c_sort'] ||= @sort_options.values[0]
    session['c_sort'] = @sort
    @comments = comment_sort(@submission.comments.unscoped.all).page(params[:c_page]).per(10).reject(&:new_record?)
  end

  def like
    return render json: { :status => "not authenticated"} if !current_user
    set_submission
    current_like = @submission.likes.where(:user => current_user).first
    if current_like
      current_like.destroy
      respond_to do |format|
        format.json { render json: { :status => 'removed like' }, status: 200 }
      end
    else
      current_dislike = @submission.dislikes.where(:user => current_user).first
      if current_dislike
        current_dislike.destroy
      end
      @submission.likes.create(:user => current_user)
      respond_to do |format|
        format.json { render json: { :status => 'liked submission' }, status: 200 }
      end
    end
  end

  def dislike
    return render json: { :status => "not authenticated"} if !current_user
    set_submission
    current_dislike = @submission.dislikes.where(:user => current_user).first
    if current_dislike
      current_dislike.destroy
      respond_to do |format|
        format.json { render json: { :status => 'removed dislike' }, status: 200 }
      end
    else
      current_like = @submission.likes.where(:user => current_user).first
      if current_like
        current_like.destroy
      end
      @submission.dislikes.create(:user => current_user)
      respond_to do |format|
        format.json { render json: { :status => 'disliked submission' }, status: 200 }
      end
    end
  end

  def destroy
    return redirect_to root_path, :alert => 'No permission.' unless @submission.can_manage(current_user)
    @submission.destroy
  end

  def new
    @submission = Submission.new
  end

  def edit
    return redirect_to root_path, :alert => 'No permission.' unless @submission.can_manage(current_user)
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.creator = current_user
    if @submission.save
      redirect_to @submission, :notice => "Successfully created a new submission!"
    else
      render 'edit', :alert => "Failed to save your submission."
    end
  end

  def update
    if @submission.update_attributes(submission_params)
      return redirect_to @submission, :notice => "Successfully saved your changes."
    else
      return redirect_to @submission, :alert => 'Unable to save your changes.'
    end
  end

  private
  def set_submission
    @submission = Submission.find(params[:id] ||= params[:submission_id])
  end

  def submission_params
    params.require(:submission).permit(:body, :name)
  end

end
