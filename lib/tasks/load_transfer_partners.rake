require 'csv'

desc "Load Transfer Partners"
task :load_transfer_partners => :environment do
  csv_text = Rails.root.join('lib', 'seeds', 'transfer_partners.csv')
  CSV.foreach(csv_text, :headers => true, :header_converters => :symbol, :converters => :numeric) do |row|
    transfer_partner = row[0].rstrip
    image_url        = row[1]
    TransferPartner.create(name: transfer_partner, image_url: image_url)
    puts "Loaded #{transfer_partner} into the database with the image_url: #{image_url}"
  end
end
