class UserMailer < ApplicationMailer
  def welcome_email(user)
    binding.pry
    @user = user
    mail(to: @user.email, subject: "Welcome to Too Many Miles!")
  end
end
