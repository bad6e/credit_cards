class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @blogs = Blog.order('created_at DESC').where(published: true).limit(3)
    mail(to: @user.email, subject: "Welcome to Too Many Miles!", reply_to: "bret@toomanymiles.com")
  end

  def blog_email(blog, user, recent_blogs)
    @user = user
    @blog = blog
    @recent_blogs = recent_blogs
    mail(to: @user.email, subject: @blog.meta_title, reply_to: "bret@toomanymiles.com")
  end
end
