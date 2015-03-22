class SubmissionsController < ApplicationController
  before_filter :set_submission, only: [:show]

  def index
    @submissions = Submission.all
  end

  def show
  end

  def new
  end

  def edit
  end

  private
  def set_submission
    @submission = Submission.find(params[:id])
  end
end
