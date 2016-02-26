require 'csv'

class Parser
  def self.parse_csv(filename, date)
    CSV.foreach(filename.path, :headers => true, :header_converters => :symbol) do |row|
      check_if_card_exists(row, date)
    end
  end

  def self.check_if_card_exists(row, date)
    if cards.has_key?(row[:name_of_credit_card])
      specific_card = Card.find_by(name: find_card_name(row))
      update_card_attributes(specific_card, row)
      update_card_rewards(specific_card, row, date)
    end
  end

  def self.find_card_name(row)
    cards[row[:name_of_credit_card]]
  end

  def self.update_card_attributes(card, row)
    card.update!(annual_fee: row[:af],
                best_offer: row[:best_offer],
                flyer_talk_link: row[:flyertalk_link])

  end

  def self.update_card_rewards(card_id, row, date)
    if (row[:current_bonus] != "" and row[:current_bonus] != "0")
      Reward.create!(amount: row[:current_bonus].gsub(",",""),
                    record_date: date,
                    spending_amount: row[:minimum_spend].gsub(",","").gsub("$",""),
                    length_of_time: row[:months_to_min_spend],
                    apply_link: row[:offer_link],
                    card_id: card_id.id )

    end
  end

  #FOR TESTING
  def self.cards
    {"Arrival +" => "Barclaycard Arrival Plus™ World Elite MasterCard®",
    "Venture Rewards" => "Capital One® Venture® Rewards Credit Card",
    "Sapphire Preferred" => "Chase Sapphire Preferred® Card",
    "Southwest Premier" => "Southwest Airlines Rapid Rewards® Premier Credit Card",
    "Southwest Plus" => "Southwest Rapid Rewards® Plus Credit Card"}
  end


  # FOR DEVELOPMENT
  # def self.cards
  #   {"Gold Delta Business" => "Gold Delta SkyMiles® Business Credit Card from American Express",
  #   "Starwood Preferred Guest (SPG)" => "Starwood Preferred Guest® Credit Card from American Express",
  #   "Arrival +" => "Barclaycard Arrival Plus™ World Elite MasterCard®",
  #   "QuicksilverOne Rewards" => "Capital One® QuicksilverOne® Cash Rewards Credit Card",
  #   "Freedom" => "Chase Freedom®",
  #   "Sapphire Preferred" => "Chase Sapphire Preferred® Card",
  #   "Marriott" => "Marriott Rewards® Premier Credit Card",
  #   "Southwest Premier" => "Southwest Airlines Rapid Rewards® Premier Credit Card",
  #   "Aeroplan" => "TD Aeroplan™ Visa Signature® Credit Card"}
  # end


  #FOR PRODUCTION
  # def self.cards
  #   {"Gold Delta" => "Gold Delta SkyMiles® Credit Card from American Express",
  #   "Gold Delta Business" => "Gold Delta SkyMiles® Business Credit Card from American Express",
  #   "Everyday" => "The Amex EveryDay® Credit Card from American Express",
  #   "Everyday Preferred" => "The Amex EveryDay® Preferred Credit Card from American Express",
  #   "Business Rewards Gold (BRG)" => "The Business Gold Rewards Card from American Express OPEN",
  #   "Platinum" => "The Platinum Card® from American Express",
  #   "Platinum Business" => "The Business Platinum Card® from American Express OPEN",
  #   "Starwood Preferred Guest (SPG)" => "Starwood Preferred Guest® Credit Card from American Express",
  #   "Starwood (SPG) Business" => "Starwood Preferred Guest® Business Credit Card from American Express",
  #   "HHonors" => "Hilton HHonors™ Card from American Express",
  #   "Alaska" => "Alaska Airlines Visa Signature® Credit Card",
  #   "Arrival" => "Barclaycard Arrival™ World MasterCard®",
  #   "Arrival +" => "Barclaycard Arrival Plus™ World Elite MasterCard®",
  #   "Venture One Rewards" => "Capital One® VentureOne® Rewards Credit Card",
  #   "Venture Rewards" => "Capital One® Venture® Rewards Credit Card",
  #   "QuicksilverOne Rewards" => "Capital One® QuicksilverOne® Cash Rewards Credit Card",
  #   "Freedom" => "Chase Freedom®",
  #   "Sapphire Preferred" => "Chase Sapphire Preferred® Card",
  #   "Ink Plus" => "Ink Plus® Business Credit Card",
  #   "IHG" => "IHG® Rewards Club Select Credit Card",
  #   "Marriott" => "Marriott Rewards® Premier Credit Card",
  #   "Southwest Premier" => "Southwest Airlines Rapid Rewards® Premier Credit Card",
  #   "United Explorer" => "United MileagePlus® Explorer Card",
  #   "British Airways" => "British Airways Visa Signature® Card",
  #   "AAdvantage Platinum" => "Citi® / AAdvantage® Platinum Select® MasterCard®",
  #   "AAdvantage Platinum Business" => "CitiBusiness® / AAdvantage® Platinum Select® World MasterCard®",
  #   "AAdvantage Executive" => "Citi® / AAdvantage® Executive World Elite™ MasterCard®",
  #   "Expedia+" => "Expedia®+ Card from Citi",
  #   "Expedia+ Voyager" => "Expedia®+ Voyager Card from Citi",
  #   "Hilton Visa" => "Citi® Hilton HHonorsTM Visa Signature® Card",
  #   "ThankYou Preferred" => "Citi ThankYou® Preferred Card — Earn 20,000 Bonus Points",
  #   "ThankYou Preferred Student" => "Citi ThankYou® Preferred Card for College Students",
  #   "Prestige" => "Citi Prestige® Card",
  #   "Virgin America" => "Virgin America Visa Signature® Card",
  #   "Aeroplan" => "TD Aeroplan™ Visa Signature® Credit Card ",
  #   "FlexPerks Travel Rewards (Visa)" => "U.S. Bank FlexPerks® Travel Rewards Visa Signature® Card "}
  # end
end