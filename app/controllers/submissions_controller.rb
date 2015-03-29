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
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:body, :name)
  end

end
