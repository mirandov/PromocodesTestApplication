class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = activate_user_url(user.activation_token)
    mail(:to => user.email,
         :subject => "Welcome to My Awesome Site")
  end

  def activation_success_email(user)
    @user = user
    @url  = login_path
    mail(:to => user.email,
         :subject => "Your account is now activated")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(:to => user.email,
         :subject => "Your password has been reset")
   end
end
