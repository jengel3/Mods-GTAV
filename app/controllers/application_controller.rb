class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  include ApplicationHelper
  
  def set_locale
    if current_user && current_user.lang
      return I18n.locale = current_user.lang
    end
    I18n.locale = session[:lang] ||= extract_locale_from_accept_language_header ||= params[:lang] ||= I18n.default_locale
  end

  def set_lang
    if !I18n.available_locales.map(&:to_s).include?(params[:lang])
      return redirect_to root_path, :alert => t('misc.invalid_language')
    end
    if current_user
      current_user.lang = params[:lang]
      current_user.save
    else
      session[:lang] = params[:lang]
    end
  end

  def profile
    @user = User.where(:username => params[:username]).first
    return redirect_to root_path, :alert => t('database.not_found', :kind => t('database.user')) if !@user
  end

  def contact
    sec = "6LfAOwUTAAAAAMHka5yC67X9AxMdNs0Sr0C7MaB1"
    request_ip = get_request_ip
    captcha_resp = params["g-recaptcha-response"]
    if !captcha_resp || captcha_resp.blank?
      flash[:alert] = t('contact.complete_captcha')
      return redirect_to root_path
    end
    google_resp = HTTParty.get("https://www.google.com/recaptcha/api/siteverify?secret=#{sec}&response=#{captcha_resp}&remoteip=#{request_ip}")
    result = JSON.parse(google_resp.body)
    if !result['success']
      flash[:alert] = t('contact.bot')
      return redirect_to root_path
    end
    form = params[:contact]
    email = form[:email]
    username = form[:username]
    message = form[:message]
    if email.empty? || username.empty? || message.empty?
      return redirect_to root_path, :alert => t('contact.please_fill')
    end
    UserMailer.contact(username, email, message).deliver_later
    redirect_to root_path, :notice => t('contact.successfully_sent')
  end

  def search
    @query = params[:search][0] ||= params[:search]
    if @query.strip.blank?
      @submissions = []
    else
      @submissions = Submission.search(@query).records
    end
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

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
