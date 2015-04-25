class Admin::HomeController < Admin::BaseController
  def index
  end

  def flush
    REDIS.flushall
    redirect_to [:admin, :home], alert: "Successfully cleared cache."
  end
end
