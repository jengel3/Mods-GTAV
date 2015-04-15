class HomeController < ApplicationController
  def index
    @submissions = Submission.approved.order('approved_at DESC').page(1).per(15)
  end
end
