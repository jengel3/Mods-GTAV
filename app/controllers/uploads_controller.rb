class UploadsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!, only: [:approve]
  before_filter :require_admin, only: [:approve]
  def create
    @submission = Submission.find(params[:submission_id])
    return redirect_to root_path, :alert => t('database.no_permission') unless @submission.can_manage(current_user)
    @upload = @submission.uploads.new(upload_params)
    if @submission.approved_at
      @upload.approved_at = DateTime.now
    end
    if @upload.save
      respond_to do |format|
        format.js
        format.html { redirect_to submission_path(@submission), :notice => t('submissions.successfully_uploaded') }
      end
    else
      respond_to do |format|
        format.js
        format.html { render 'edit' }
      end
    end
  end

  def download
    upload = Upload.find(params[:id])
    send_file upload.upload.path
  end

  def approve
    @upload = Upload.find(params[:upload_id])
    @submission = @upload.submission
    @submission.approved_at = DateTime.now
    @submission.last_updated = DateTime.now
    @submission.save
    @upload.approved_at = DateTime.now
    @upload.save
    redirect_to [:admin, :content], :notice => t('submissions.successfully_action', action: t('submissions.approved'))
  end

  def deny
    @upload = Upload.find(params[:upload_id])
    @submission = @upload.submission
    @upload.destroy
    @submission.approved_at = nil
    @submission.save
    redirect_to [:admin, :content], :notice => t('submissions.successfully_action', action: t('submissions.denied'))
  end

  private
  def upload_params
    params.require(:upload).permit(:version, :changelog, :upload)
  end
end
