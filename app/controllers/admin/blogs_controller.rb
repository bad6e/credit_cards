
class Admin::BlogsController < Admin::BaseController
  before_action :load_blog, only: [:edit, :update, :destroy]
  before_action :find_associated_cards

  def index
    @blogs = Blog.all.order('created_at DESC')
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params.except(:cards))
    if @blog.save
      assign_cards_to_blog(@associated_cards)
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
    if @blog.update(blog_params.except(:cards))
      assign_cards_to_blog(@associated_cards)
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

    def find_associated_cards
      if params[:blog] && params[:blog][:cards]
        @associated_cards = params[:blog][:cards]
      end
    end

    def assign_cards_to_blog(selected_cards)
      selected_cards.each do |id|
        if ((id != "") and (card_not_already_assigned_to_blog(id) == false))
          card = Card.find(id)
          @blog.cards << card
        end
      end
    end

    def card_not_already_assigned_to_blog(id)
      @blog.cards.include?(Card.find(id))
    end

    def blog_params
      params.require(:blog).permit(:meta_title,
                                   :meta_description,
                                   :slug,
                                   :image_url,
                                   :cards => [])
    end
end
