class Api::V1::UploadsController < Api::V1::BaseController
  before_filter :set_submission
  
  def index
    @uploads = @submission.uploads

    serialize_uploads = ActiveModel::ArraySerializer.new(@uploads, each_serializer: UploadSerializer)

    respond_to do |format|
      format.json { render json: serialize_uploads }
    end
  end

  def show
    @upload = @submission.uploads.find(params[:id])
    respond_to do |format|
      format.json { render json: @upload }
    end
  end

  def destroy
    @upload = @submission.uploads.find(params[:id])
    @upload.destroy
  end

  def create
    # TODO File uploads
  end

  private
  def set_submission
    @submission = Submission.find(params[:submission_id])
  end

  def upload_params
    params.permit(:name, :changelog, :upload)
  end
end
