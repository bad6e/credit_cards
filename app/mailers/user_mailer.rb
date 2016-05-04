class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @blogs = Blog.order('created_at DESC').where(published: true).limit(3)
    mail(to: 'doucette.bret@gmail.com', subject: "Welcome to Too Many Miles!", reply_to: "bret@toomanymiles.com")
  end
end
