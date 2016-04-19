class CategoriesController < ApplicationController
  def index
  end

  def show
    if show_category_page_request(params)
      @category_presenter = CategoryPresenter.new(params)
    else
      redirect_to category_path(find_category(params))
    end
  end

  private

    def find_category(params)
      Category.friendly.find(params[:category][:category_id])
    end

    def show_category_page_request(params)
      params[:category].nil?
    end
end