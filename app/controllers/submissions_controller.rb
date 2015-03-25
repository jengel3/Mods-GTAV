class SubmissionsController < ApplicationController
  include CommentsHelper
  before_filter :set_submission, only: [:show, :destroy]

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
  end

  def destroy
    @submission.destroy
  end

  def new
    @submission = Submission.new
  end

  def edit
  end

  private
  def set_submission
    @submission = Submission.find(params[:id])
  end
end
