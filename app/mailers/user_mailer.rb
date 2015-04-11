class UserMailer < BaseMailer
  def welcome(user)
    @user = user
    return if !@user.accepts_emails || @user.email.nil?
    mail(:to => @user.email,
      :subject => "Welcome to Mods-GTAV!",
      :reply_to => @@reply)
  end
end
