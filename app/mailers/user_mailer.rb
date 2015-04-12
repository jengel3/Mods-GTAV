class UserMailer < BaseMailer
  def welcome(user)
    @user = user
    return if !@user.accepts_emails || @user.email.nil?
    mail(:to => @user.email,
      :subject => "Welcome to Mods-GTAV!",
      :reply_to => @@reply,
      :from => "no-reply@mods-gtav.com")
  end

  def contact(username, email, message)
    @message = inquiry.gsub(/\r\n/, "<br>")
    @username = username
    @email = email
    mail(:to => "support@mods-gtav.com",
      :subject => "#{username} has sent a message to Mods-GTAV",
      :reply_to => email)
  end
end
