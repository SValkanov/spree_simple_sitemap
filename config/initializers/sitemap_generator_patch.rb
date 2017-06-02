DynamicSitemaps::SitemapGenerator.class_eval do
  def protocol
    sitemap.protocol
  end

  def write_beginning
    write '<?xml version="1.0" encoding="UTF-8"?>',
          '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">'
  end

  def write_url(url, options = {})
    write '<url>'
    write '<loc>' + format_url(url) + '</loc>'
    if image_urls = options[:image_urls]
      image_urls.flatten(1).each do |image_url|
        write '<image:image>'
        write '<image:loc>' + format_url(image_url) + '</image:loc>'
        write '</image:image>'
      end
    end
    if last_mod = options[:last_mod]
      write '<lastmod>' + format_date(last_mod) + '</lastmod>'
    end
    if change_freq = options[:change_freq]
      write '<changefreq>' + change_freq + '</changefreq>'
    end
    if priority = options[:priority]
      write '<priority>' + priority.to_s + '</priority>'
    end
    write '</url>'
  end
end
