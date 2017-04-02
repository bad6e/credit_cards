require 'csv'

desc "Dump User Emails"
task :dump_user_emails => :environment do
  file = "#{Rails.root}/public/user_emails.csv"

  users = User.all

  column_headers = ["Email"]

  CSV.open(file, 'w', write_headers: true, headers: column_headers) do |writer|
    users.each do |user|
      writer << [user.email]
    end
  end
end