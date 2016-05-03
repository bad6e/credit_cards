class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: 'doucette.bret@gmail.com', subject: "Welcome to Too Many Miles!")
  end
end
