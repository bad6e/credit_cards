class MonthlyValuations
  require 'nokogiri'
  require 'open-uri'
  require 'models/useragent'

  include UserAgent

  attr_reader :page

  def initialize(month, url)
    @user_agent         = UserAgent::OpenFile.new.open_file
    @month              = format_month_params(month)
    @year               = format_year_params(month)
    @page               = open_page(url, @user_agent.sample[0])
    @program_valuations = program_valuations
    update_cards_rewards
  end

  def open_page(url, user_agent)
    if Rails.env == "test"
      Nokogiri::XML(open(Rails.root.to_s + "/spec/fixtures/cent_value.html"))
    else
      Nokogiri::HTML(open(url, "User-Agent" => user_agent))
   end
  end

  def format_month_params(date)
    date.split("-")[-1].to_i
  end

  def format_year_params(date)
    date.split("-")[0].to_i
  end

  def program_valuations
    programs_and_values = join_pc_values
    programs_and_values.each do |key,value|
      if value.class == String && value.include?("-")
        programs_and_values[key] = format_range_cent_values(value).inject(0, :+)/2
      end
    end
    programs_and_values
  end

  def format_range_cent_values(value)
    value.split("-").map do |cent_value|
      cent_value.to_f
    end
  end

  def join_pc_values
    program_names.zip(cent_values).to_h
  end

  def program_names
    @page.css("table").css("tr").map do |name|
      name.elements.first.text
    end
  end

  def cent_values
    stuff = @page.css("table").css("tr").map do |name|
      if name.elements[3] == nil
      else
        name.elements[3].text
      end
    end
  end

  def update_cards_rewards
    list = program_names.each do |name|
      if program_key.has_key?(name)
        Card.where(point_type: program_key[name]).each do |card|
          find_card_rewards_with_specific_month_and_year(card).each do |reward|
            reward.update(cent_value: @program_valuations[name].to_f/100)
            reward.update(dollar_amount: reward.cent_value * reward.amount)
          end
        end
      end
    end
  end

  def find_card_rewards_with_specific_month_and_year(card)
    card.rewards.where('extract(month from record_date) = ? AND extract(year from record_date) = ?', @month, @year)
  end

  def program_key
    {
      "Southwest" => "Southwest Rapid Rewards®",
      "American" => "American AAdvantage® Miles",
      "American Express Membership Rewards" => "American Express Membership Rewards®",
      "Barclaycard Arrival Miles" => "Barclaycard Arrival™ Miles",
      "Capital One" => "Capital One® Venture Miles",
      "Chase Ultimate Rewards" => "Chase Ultimate Rewards®",
      "Citi ThankYou" => "Citi ThankYou® Rewards",
      "Diners Club Rewards" => "Diners Club Rewards®",
      "FlexPerks" => "U.S. Bank FlexPoints",
      "Aeroplan" => "Aeroplan Miles",
      "Alaska" => "Alaska Airlines Mileage Plan™",
      "ANA" => "ANA Mileage Club Miles",
      "Avianca" => "Avianca LifeMiles",
      "British Airways" => "British Airways Avios",
      "Delta" => "Delta SkyMiles®",
      "Emirates" => "Emirates Skywards",
      "Etihad" => "Etihad™ Guest Miles",
      "Flying Blue" => "Air France Flying Blue Miles",
      "Frontier" => "Frontier Miles",
      "JetBlue" => "JetBlue Points",
      "Miles & More" => "Lufthansa Miles & More®",
      "Singapore Airlines" => "Singapore Airlines KrisFlyer Miles",
      "United" => "United MileagePlus® Miles",
      "Virgin America" => "Virgin America Points",
      "Virgin Atlantic" => "Virgin Atlantic Flying Club Miles",
      "Club Carlson" => "Club Carlson Gold Points",
      "Choice Privileges" => "Choice Privileges®",
      "Hilton" => "Hilton HHonors Points",
      "Hyatt" => "Hyatt Gold Passport Points",
      "IHG" => "IHG® Rewards Club",
      "Marriott" => "Marriott Reward Points",
      "Ritz-Carlton" => "The Ritz-Carlton Rewards",
      "Starwood" => "Starwood Starpoints",
      "Wyndham" => "Wyndham Rewards®",
      "Amtrak" => "Amtrak Guest Rewards®"
    }
  end
end


