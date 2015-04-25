include ActionView::Helpers::TextHelper
class Admin::ListingsController < Admin::BaseController
  def users
    @users = User.all
    @users = @users.order(column(User, 'username') + ' ' + direction)
    @users = @users.page(params[:page]).per(20)
  end

  def moderate
    return redirect_to :back, alert: "Please specify a type" if !params[:type].present?
    object = params[:type].singularize.classify.constantize
    count = params[:objects].count ||= 0
    failed = 0
    params[:objects].each do |k, v|
      o = object.find(k)
      o ? o.destroy : failed += 1
    end
    flash[:notice] = "Successfully deleted #{pluralize(count, params[:type].downcase)}."
    if failed > 0
      flash[:notice] += " #{failed} failed."
    end
    redirect_to :back
  end

  private
  def column(table, default='name')
    return table.column_names.include?(params[:field]) ? params[:field] : default
  end

  def direction
    return ["asc", "desc"].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
