require 'csv'

desc "Load Card Programs"
task :load_card_programs => :environment do
  csv_text = Rails.root.join('lib', 'seeds', 'card_programs.csv')
  CSV.foreach(csv_text, :headers => true, :header_converters => :symbol, :converters => :numeric) do |row|
    card_program = row[0].rstrip
    CardProgram.create(name: card_program)
    puts "Loaded #{card_program} into the database"
  end
end