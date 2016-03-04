require 'csv'
require 'cardlist'
require 'rake'
Rake::Task.clear
CreditCards::Application.load_tasks

class Parser

  include CardList

  def initialize
    @card             ||= CardList::CardTables.new
    @card_production  ||= @card.cards_production
    @card_development ||= @card.cards_development
    @card_test        ||= @card.cards_test
    @environment        = Rails.env
  end

  def parse_csv(filename, date)
    CSV.foreach(filename.path, :headers => true, :header_converters => :symbol) do |row|
      @row  = row
      @date = date
      environment_list[@environment].call
      Rake::Task["set_best_offer"].invoke
    end
  end

  def environment_list
     {'production' => lambda{check_if_card_exists(@row, @date, @card_production)},
     'development' => lambda{check_if_card_exists(@row, @date, @card_development)},
     'test' => lambda{check_if_card_exists(@row, @date, @card_test)}}
  end

  def check_if_card_exists(row, date, card_table)
    if card_table.has_key?(row[:name_of_credit_card])
      specific_card = Card.find_by(name: find_card_name(row, card_table))
      update_card_attributes(specific_card, row)
      create_card_rewards(specific_card, row, date)
    end
  end

  def find_card_name(row, card_table)
    card_table[row[:name_of_credit_card]]
  end

  def update_card_attributes(card, row)
    card.update!(annual_fee: row[:af],
                 flyer_talk_link: row[:flyertalk_link])

  end

  def create_card_rewards(card, row, date)
    if (row[:current_bonus] != "" and row[:current_bonus] != "0")
      Reward.create!(amount: row[:current_bonus].gsub(",",""),
                     record_date: date,
                     spending_amount: row[:minimum_spend].gsub(",","").gsub("$",""),
                     length_of_time: row[:months_to_min_spend],
                     apply_link: row[:offer_link],
                     card_id: card.id )

    end
  end
end