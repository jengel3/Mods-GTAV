class SubmissionsController < ApplicationController
  include CommentsHelper
  include ApplicationHelper
  before_filter :set_submission, only: [:destroy, :edit, :update, :download]
  before_filter :authenticate_user!, only: [:destroy, :edit, :create, :new, :update]

  def index
    category = params[:category]
    subcategory = params[:subcategory]
    @sort = params[:sort]
    @time = params[:time]
    @submissions = Submission.all
    @sort_options = {
      'Newest' => 'newest',
      'Oldest' => 'oldest',
      'Updated' => 'updated',
      'Popular' => 'downloads',
      'Most Liked' => 'likes'
    }
    @time_options = {
      'Now' => 'today', 
      'This Week' => 'week',
      'This Month' => 'month',
      'All Time' => 'all'
    }
    if category
      @submissions = @submissions.where(:category => category)
      @subcategories = CATEGORIES[category.to_sym] || nil
    end
    if subcategory && subcategory != 'all'
      @submissions = @submissions.where(:sub_category => subcategory)
    end
    if @sort
      @submissions = reg_sort(@sort, @submissions) 
    end
    if @time && @time != 'all'
      @submissions = time_sort(@time, @submissions)
    end
    @submissions = @submissions.page(params[:page]).per(21)
    @sort = @sort_options.key(@sort) || @sort_options.keys[0]
    @time = @time_options.key(@time) || @time_options.keys[0]
  end

  def show
    @submission = Submission.find(params[:id])
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
    @rating = nil
    if current_user
      if @submission.has_liked(current_user)
        return @rating = 'like'
      elsif @submission.has_disliked(current_user)
        @rating = 'dislike'
      end
    end
  end

  def like
    return render json: { :status => "not authenticated"} if !current_user
    set_submission
    current_like = @submission.likes.where(:user => current_user).first
    if current_like
      current_like.destroy
      @submission.like_count -= 1
      @submission.update_rating
      respond_to do |format|
        format.json { render json: { :status => 'removed like', :count => @submission.avg_rating }, status: 200 }
      end
    else
      current_dislike = @submission.dislikes.where(:user => current_user).first
      if current_dislike
        @submission.dislike_count -= 1
        current_dislike.destroy
      end
      @submission.likes.create(:user => current_user)
      @submission.like_count += 1
      @submission.update_rating
      respond_to do |format|
        format.json { render json: { :status => 'liked submission', :count => @submission.avg_rating }, status: 200 }
      end
    end
  end

  def dislike
    return render json: { :status => "not authenticated"} if !current_user
    set_submission
    current_dislike = @submission.dislikes.where(:user => current_user).first
    if current_dislike
      current_dislike.destroy
      @submission.dislike_count -= 1
      @submission.update_rating
      respond_to do |format|
        format.json { render json: { :status => 'removed dislike', :count => @submission.avg_rating }, status: 200 }
      end
    else
      current_like = @submission.likes.where(:user => current_user).first
      if current_like
        @submission.like_count -= 1
        current_like.destroy
      end
      @submission.dislikes.create(:user => current_user)
      @submission.dislike_count += 1
      @submission.update_rating
      respond_to do |format|
        format.json { render json: { :status => 'disliked submission', :count => @submission.avg_rating }, status: 200 }
      end
    end
  end

  def download
    latest = @submission.latest
    return if !latest
    @submission.downloads.create(:ip_address => get_request_ip)
    send_file latest.upload.path
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
    params.require(:submission).permit(:body, :name, :category, :sub_category)
  end

  def time_sort(timeframe, submissions)
    case timeframe.downcase
    when 'today'
      submissions.where('approved_at >= ?', Time.now - 24.hours)
    when 'week'
      submissions.where('approved_at >= ?', Time.now - 7.days)
    when 'month'
      submissions.where('approved_at >= ?', Time.now - 1.month)
    else
      submissions
    end
  end

  def reg_sort(sort, submissions)
    case sort.downcase
    when 'newest'
      submissions.order('approved_at DESC')
    when 'oldest'
      submissions.order('approved_at ASC')
    when 'updated'
      submissions.order('last_updated DESC')
    when 'downloads'
      submissions.order('download_count DESC')
    when 'likes'
      submissions.order('avg_rating DESC')
    else
      submissions
    end
  end
end
