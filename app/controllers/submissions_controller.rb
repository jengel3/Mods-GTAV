class SubmissionsController < ApplicationController
  include CommentsHelper
  before_filter :set_submission, only: [:show, :destroy, :edit, :update]
  before_filter :authenticate_user!, only: [:destroy, :edit, :create, :new, :update]

  def index
    @submissions = Submission.all
  end

  def show
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
  
    images = @submission.thumbnails.sort_by { |i| [i.location[ -1..-1 ], i] }
    @thumbnails = {}
    previous = 0
    images.each do |image|
      while image.num != previous + 1 do
        @thumbnails[previous + 1] = nil
        previous += 1
      end
      @thumbnails[previous] = image
      previous += 1
    end
  end

  def destroy
    @submission.destroy
  end

  def new
    @submission = Submission.new
  end

  def edit
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
