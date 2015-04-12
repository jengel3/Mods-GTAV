class UploadsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!, only: [:approve]
  before_filter :require_admin, only: [:approve]
  def create
    @submission = Submission.find(params[:submission_id])
    return redirect_to root_path, :alert => 'No permission.' unless @submission.can_manage(current_user)
    @upload = @submission.uploads.new(upload_params)
    if @upload.save
      respond_to do |format|
        format.json { render json: {:status => "upload successful"}, status: 200 }
        format.html { redirect_to submission_path(@submission), :notice => 'Successfully uploaded a file.' }
      end
    else
      respond_to do |format|
        format.json { render json: {:errors => @upload.errors}, status: 422 }
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
    @submission.save
    redirect_to [:admin, :content], :notice => "Successfully approved a submission."
  end

  def deny
    @upload = Upload.find(params[:upload_id])
    @submission = @upload.submission
    @upload.destroy
    @submission.approved_at = nil
    @submission.save
    redirect_to [:admin, :content], :notice => "Successfully denied a submission."
  end

  private
  def upload_params
    params.require(:upload).permit(:version, :changelog, :upload)
  end
end
