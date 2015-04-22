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
      redirect_to root_path, :notice => t('videos.success')
    else
      redirect_to root_path, :alert => t('videos.failed')
    end
  end

  def destory
    @video = Video.find(params[:id])
    @video.destory
    redirec_to root_path, :notice => t('videos.removed')
  end

  private
  def video_params
    params.require(:video).permit(:url)
  end
end
