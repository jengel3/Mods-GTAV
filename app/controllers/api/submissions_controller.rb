class Api::SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  def index
    @submissions = Submission.all
    serialized_submissions = ActiveModel::ArraySerializer.new(@submissions, each_serializer: SubmissionSerializer)

    respond_to do |format|
      format.html # index.html.erb
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
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def submission_params
      params.require(:submission).permit(:name, :body, :type)
    end
end
