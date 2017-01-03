class Api::V1::RelatedBlogsController < ApplicationController
  respond_to :json

  def show
    related_blogs = Blog.find_related_blogs(card_id_params[:id])
    respond_with related_blogs
  end

  def show_related_blogs
    related_blogs = Blog.find_related_blogs_exclude_current_blog(load_all_cards_associated_with_single_blog, blogs_params[:id])
    respond_with related_blogs
  end

  private
    def card_id_params
      params.permit(:id)
    end

    def load_current_blog_from_params
      @_blog ||= Card.find(blogs_params[:id]).blogs.last
    end

    def blogs_params
      params.permit(:id)
    end

    def load_all_cards_associated_with_single_blog
      @_card ||= Blog.find(blogs_params[:id]).cards.pluck(:id)
    end
end
