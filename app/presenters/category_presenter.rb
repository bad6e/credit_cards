class CategoryPresenter

  attr_reader :category_id

  def initialize(params)
    @category_id = params[:id]

  end

  def find_display_id(params)
    if params[:category] != nil
      @display_id  = params[:category][:category_id]
    end
  end

  def category
    Category.friendly.find(@category_id)
  end

  def category_name
    category.parse_category_name
  end

  def number_of_cards_per_category
    category.cards.count
  end

  def categories_cards
    category.cards
  end
end
