SitemapGenerator::Sitemap.default_host = "http://www.toomanymiles.com"
SitemapGenerator::Sitemap.public_path = 'tmp/sitemaps/'

SitemapGenerator::Sitemap.create do
  add cards_path, changefreq: 'monthly'
  add categories_path
  add blog_path, changefreq: 'weekly'
  add about_path

  Card.find_each do |card|
    add card_path(card), lastmod: card.updated_at
  end

  Category.find_each do |category|
    add category_path(category.slug), lastmod: category.updated_at
  end
end
