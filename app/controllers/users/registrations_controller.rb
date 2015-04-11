class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
   super
   UserMailer.welcome(@user).deliver_later unless @user.invalid?
  end

  def update
    @user = User.find(current_user.id)
    user = params[:user]
    password_changed = !user[:password].to_s.strip.blank?

    update_completed = if password_changed
      @user.update_with_password(user.permit(:biography, :username, :email_approval, :email_reports, :email_comments, :email_news, :email, :avatar, :remove_avatar, :password, :password_confirmation, :current_password))
    else
      @user.update_without_password(user.permit(:biography, :username, :email_approval, :email_reports, :email_comments, :email_news, :email, :avatar, :remove_avatar))
    end

    if update_completed
      sign_in @user, :bypass => true
      redirect_to profile_path(@user.username), :notice => "Updated account settings."
    else
      clean_up_passwords @user
      respond_with @user
    end
  end
end  