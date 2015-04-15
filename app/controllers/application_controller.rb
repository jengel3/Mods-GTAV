class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper
  
  def profile
    @user = User.where(:username => params[:username]).first
    return redirect_to root_path, :alert => "User not found." if !@user
  end

  def contact
    sec = "6LfAOwUTAAAAAMHka5yC67X9AxMdNs0Sr0C7MaB1"
    request_ip = get_request_ip
    captcha_resp = params["g-recaptcha-response"]
    if !captcha_resp || captcha_resp.blank?
      flash[:alert] = "Please complete the captcha."
      return redirect_to root_path
    end
    google_resp = HTTParty.get("https://www.google.com/recaptcha/api/siteverify?secret=#{sec}&response=#{captcha_resp}&remoteip=#{request_ip}")
    result = JSON.parse(google_resp.body)
    if !result['success']
      flash[:alert] = "It appears that you are a bot. Please try again."
      return redirect_to root_path
    end
    form = params[:contact]
    email = form[:email]
    username = form[:username]
    message = form[:message]
    if email.empty? || username.empty? || message.empty?
      return redirect_to root_path, :alert => "Please fill in all fields."
    end
    UserMailer.contact(username, email, message).deliver_later
    redirect_to root_path, :notice => "Successfully sent a message to Mods GTAV. Expect a response soon."
  end

  def search
    @query = params[:search]
    @submissions = @query.blank? ? [] : Submission.search(@query).records 
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
