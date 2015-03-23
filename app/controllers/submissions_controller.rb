class SubmissionsController < ApplicationController
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
    @comments = comment_sort(@submission.comments.unscoped.all).reject(&:new_record?)
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

  def comment_sort(comments)
    sort = params[:c_sort]
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
      comments.where(:user => @submission.creator)
    when 'admin'
      comments.where(:user_id.in => User.where(:admin => true).distinct(:_id))
    else
      comments.asc('created_at')
    end
  end
end
