class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @blogs = Blog.order('created_at DESC').limit(3)
    mail(to: @user.email, subject: "Welcome to Too Many Miles!", reply_to: "bret@toomanymiles.com")
  end
end
