namespace :compress do
  task sitemap: :environment do
    `gzip -f "#{Rails.root}/public/sitemaps/sitemap.xml"`
    `gzip -f "#{Rails.root}/public/sitemaps/products.xml"`
    `gzip -f "#{Rails.root}/public/sitemaps/images.xml"`
  end
end
