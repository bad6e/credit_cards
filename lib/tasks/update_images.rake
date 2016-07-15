desc "Update Card Images to HTTPS"
task :update_card_images => :environment do
  cards = Card.all
  cards.each do |card|
    new_url = card.image_link.insert(4, "s")
    card_to_be_updated = Card.find(card.id)
    card_to_be_updated.update!(image_link: new_url)
    puts Card.find(card.id).image_link
  end
end