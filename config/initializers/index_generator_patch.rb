DynamicSitemaps::IndexGenerator.class_eval do
  def write_sitemaps(file, sitemaps)
    sitemaps.each do |sitemap|
      sitemap.files.each do |file_name|
        file.puts '<sitemap>',
                  "<loc>#{sitemap.protocol}://#{sitemap.host}/#{sitemap.folder}/#{file_name}.gz</loc>",
                  '</sitemap>'
      end
    end
  end
end
