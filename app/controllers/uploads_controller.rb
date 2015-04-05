class UploadsController < ApplicationController
  include ApplicationHelper
  def create
    @submission = Submission.find(params[:submission_id])
    @upload = @submission.uploads.new(upload_params)
    if @upload.save
      redirect_to submission_path(@submission), :notice => 'Successfully uploaded a file.'
    else
      render 'edit'
    end
  end

  def download
    upload = Upload.find(params[:id])
    send_file upload.upload.path
  end

  private
  def upload_params
    params.require(:upload).permit(:version, :changelog, :upload)
  end
end
