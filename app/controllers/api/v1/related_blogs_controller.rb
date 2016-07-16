class Api::V1::RelatedBlogsController < ApplicationController
  respond_to :json

  def show
    related_blogs = Card.find(related_blogs_params[:id]).blogs
                         .order('created_at DESC')
                         .where(published: true)
    respond_with related_blogs
  end

  def show_related_blogs
    id = related_blogs_params[:id]
    ids = Blog.find(id).cards.pluck(:id)
    related_blogs_show_page = Blog.joins(:cards)
                              .where(cards: {id: ids})
                              .where.not(id: id)
                              .uniq.shuffle[0..2]
    respond_with related_blogs_show_page
  end

  private

    def related_blogs_params
      params.permit(:id)
    end
end
