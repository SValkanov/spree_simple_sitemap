module SpreeSimpleSitemap
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_schedule
        create_file 'config/schedule.rb',
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
         protocol "http"

         sitemap_for Spree::Product, name: :products do |product|
           url "#{protocol}://#{host}/products/#{product.slug}"
         end

         sitemap_for Spree::Image, name: :images do |image|
           url "#{protocol}://#{host}#{image.attachment.url}"
         end

         ping_with "#{protocol}://#{host}/sitemap.xml"'
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
