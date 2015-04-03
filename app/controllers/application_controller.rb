class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def profile
    @user = User.where(:username => params[:username]).first
    return redirect_to root_path, :alert => "User not found." if !@user
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, 
      :email, :password, :password_confirmation, :remember_me) }

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, 
      :password, :remember_me) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:biography, 
      :email_approval, :email_comments, :email_reports, 
      :email_news, :username, :email, :password, 
      :password_confirmation, :current_password) }
  end
end
