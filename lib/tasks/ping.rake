desc 'Create the sitemap, then upload it to S3 and ping the search engines'
  task ping: :environment do
    Rake::Task["sitemap:create"].invoke
    Rake::Task["upload_to_s3"].invoke
    SitemapGenerator::Sitemap.ping_search_engines('http://www.toomanymiles.com/sitemap.xml.gz')
  end
