require 'csv'

desc "Load Main Programs"
task :load_main_programs => :environment do
  csv_text = Rails.root.join('lib', 'seeds', 'main_partners.csv')
  CSV.foreach(csv_text, :headers => true, :header_converters => :symbol, :converters => :numeric) do |row|
    card_program = row[0].rstrip
    MainProgram.create(name: card_program)
    puts "Loaded #{card_program} into the database"
  end
end