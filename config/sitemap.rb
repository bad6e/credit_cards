SitemapGenerator::Sitemap.default_host = "http://www.toomanymiles.com"
SitemapGenerator::Sitemap.public_path = 'tmp/sitemaps/'

SitemapGenerator::Sitemap.create do
  add root_path
  add about_index_path
  add categories_path
  add blogs_path

  Card.find_each do |card|
    add card_path(card), lastmod: card.updated_at
  end

  Blog.find_each do |blog|
    add blog_path(blog), lastmod: card.updated_at
  end

  Category.find_each do |category|
    add category_path(category.slug), lastmod: category.updated_at
  end
end
