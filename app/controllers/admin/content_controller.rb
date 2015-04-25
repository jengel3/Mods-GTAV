class Admin::ContentController < Admin::BaseController
  def index
    @uploads = Upload.all.joins(:submission).where('submissions.approved_at IS NULL').order('uploads.submission_id')
  end
end
