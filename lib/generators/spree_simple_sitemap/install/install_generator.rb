module SpreeSimpleSitemap
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_schedule
        append_file 'config/schedule.rb',
         "every 1.day, at: '5:00 am' do
            rake 'sitemap:generate'
            rake 'compress:sitemap'
          end"
      end

      def add_sitemap_initializer
        create_file "config/sitemap.rb",
        '# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
         # for examples of multiple hosts and folders.
         host "http://localhost:3000"

         sitemap_for Spree::Product, name: :products do |product|
           url "#{host}/products/#{product.slug}"
         end

         sitemap_for Spree::Image, name: :images do |image|
           url "#{host}#{image.attachment.url}"
         end

         # You can have multiple sitemaps like the above – just make sure their names are different.

         # Automatically link to all pages using the routes specified
         # using "resources :pages" in config/routes.rb. This will also
         # automatically set <lastmod> to the date and time in page.updated_at:
         #
         #   sitemap_for Page.scoped

         # For products with special sitemap name and priority, and link to comments:
         #
         #   sitemap_for Product.published, name: :published_products do |product|
         #     url product, last_mod: product.updated_at, priority: (product.featured? ? 1.0 : 0.7)
         #     url product_comments_url(product)
         #   end

         # If you want to generate multiple sitemaps in different folders (for example if you have
         # more than one domain, you can specify a folder before the sitemap definitions:
         #
         #   Site.all.each do |site|
         #     folder "sitemaps/#{site.domain}"
         #     host site.domain
         #
         #     sitemap :site do
         #       url root_url
         #     end
         #
         #     sitemap_for site.products.scoped
         #   end

         # Ping search engines after sitemap generation:
         #
         ping_with "#{host}/sitemap.xml"'
      end

      def add_javascripts
        #append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_simple_sitemap\n"
        #append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_simple_sitemap\n"
      end

      def add_stylesheets
        #inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_simple_sitemap\n", :before => /\*\//, :verbose => true
        #inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_simple_sitemap\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        #run 'bundle exec rake railties:install:migrations FROM=spree_simple_sitemap'
      end

      def run_migrations
        #run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        #if run_migrations
        #  run 'bundle exec rake db:migrate'
        #else
        #  puts 'Skipping rake db:migrate, don\'t forget to run it!'
        #end
      end
    end
  end
end
