class SubmissionsController < ApplicationController
  def index
    @submissions = Submission.all
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
  end

  def edit
  end
end
