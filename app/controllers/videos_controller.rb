class VideosController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!
  before_filter :require_admin

  def create
    @video = Video.new(video_params)
    @video.user = current_user
    @video.youtube_id = Video.youtube_id(@video.url)
    @video.thumb = Video.thumb_url(@video.youtube_id)
    @video.remote_vidthumb_url = @video.thumb
    if @video.save
      redirect_to root_path, :notice => "Added a new community video."
    else
      redirect_to root_path, :alert => "Unable to add the video. #{@video.errors.full_messages}"
    end
  end

  def destory
    @video = Video.find(params[:id])
    @video.destory
    redirec_to root_path, :notice => "Removed a community video."
  end

  private
  def video_params
    params.require(:video).permit(:url)
  end
end
