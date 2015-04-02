# /api/v1
class Api::V1::SubmissionsController < Api::V1::BaseController
  before_action :set_submission, only: [:show, :update, :destroy]
  before_filter :verify_permission, only: [:create, :update, :destroy]

  # GET /submissions
  def index
    @submissions = Submission.all
    serialized_submissions = ActiveModel::ArraySerializer.new(@submissions, each_serializer: SubmissionSerializer)

    respond_to do |format|
      format.json { render json: serialized_submissions }
    end
  end

  # GET /submissions/1
  def show
    respond_to do |format|
      format.json { render json: @submission }
    end
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  def update
    respond_to do |format|
      if @submission.update_attributes(submission_params)
        format.json { render json: {:status => 'okay'}, status: :ok }
      else
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
    respond_to do |format|
      format.json { render json: {status: 'okay'}, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Verify that this user has the correct permissions to modify this model
    def verify_permission
      unless @user == @submission.creator || @user.admin
        return respond_to do |format|
          format.json { render json: {:status => 'not permitted'}, status: 401 }
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    def submission_params
      fields = [:name, :body, :category, :sub_category]
      params.permit(fields)
    end
  end
