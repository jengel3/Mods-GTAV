class HomeController < ApplicationController
  def index
    @submissions = Submission.approved.order('approved_at DESC').page(1).per(15)
  end

  def infinite
    @submissions = Submission.approved.order('approved_at DESC').page(params[:page]).per(15)
    respond_to do |format|
      format.js
    end
  end
end
