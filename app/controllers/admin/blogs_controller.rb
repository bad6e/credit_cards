class Admin::BlogsController < Admin::BaseController
  before_action :load_blog, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all.order('created_at DESC')
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Blog successfully created!"
      redirect_to admin_blogs_path
    else
      flash.now[:errors] = @blog.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      flash[:success] = "Blog successfully updated!"
      redirect_to admin_blogs_path
    else
      flash.now[:errors] = @blog.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy

  end

  private

    def load_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def slug_title
      binding.pry
    end

    def blog_params
      params.require(:blog).permit(:meta_title,
                                   :meta_description,
                                   :slug)
    end
end
