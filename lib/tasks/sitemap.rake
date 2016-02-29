 desc 'Upload the sitemap files to S3'
  task upload_to_s3: :environment do
    puts "Starting sitemap upload to S3..."
    s3 = Aws::S3::Resource.new(region:'us-east-1')
    bucket = s3.bucket(ENV['S3_BUCKET_NAME'])
    Dir.entries(File.join(Rails.root, 'tmp', 'sitemaps')).each do |file_name|
      next if %w(. .. .DS_Store).include? file_name
      path = "sitemap/#{file_name}"
      file = File.join(Rails.root, 'tmp', 'sitemaps', file_name)
      object = bucket.object(path)
      object.upload_file(file)
      puts "Saved #{file_name} to S3"
    end
  end