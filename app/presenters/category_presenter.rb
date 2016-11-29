class CategoryPresenter

  attr_reader :category_id

  def initialize(params)
    @category_id = params[:id]
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

  def excluded_ids
    Category.exclude_ids
  end
end
