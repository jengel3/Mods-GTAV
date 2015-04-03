class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # def create
  #  super
  #  UserMailer.welcome(@user).deliver_later unless @user.invalid?
  # end

  def edit
    @user = current_user
    puts @user.errors.to_json, "ERRORS ADAMMT"
  end

  def update
    @user = User.find(current_user.id)
    user = params[:user]
    password_changed = !user[:password].to_s.strip.blank?

    update_completed = if password_changed
      @user.update_with_password(user.permit(:biography, :username, :email_approval, :email_reports, :email_comments, :email_news, :email, :password, :password_confirmation, :current_password))
    else
      @user.update_without_password(user.permit(:biography, :username, :email_approval, :email_reports, :email_comments, :email_news, :email))
    end

    if update_completed
      sign_in @user, :bypass => true
      redirect_to profile_path(@user.username), :notice => "Updated account settings."
    else
      puts @user.errors.to_json, 'errors'
      redirect_to edit_user_registration_path, :alert => "Failed to update settings" 
    end
  end
end  