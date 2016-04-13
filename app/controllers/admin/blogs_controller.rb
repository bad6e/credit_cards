class Admin::BlogsController < ApplicationController
  before_action :load_blog, only: [:edit, :update, :destroy]

  def index

  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Blog successfully created!"
      redirect_to edit_admin_card_path(blog_params[:card_id])
    else
      flash.now[:errors] = @blog.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update

  end

  def destroy

  end

  private

    def load_blog
      @blog = Blog.find(params[:id])
    end

end
