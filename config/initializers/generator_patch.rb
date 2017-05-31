DynamicSitemaps::Generator.class_eval do
  def sitemap(*args, &block)
    args << {} unless args.last.is_a?(Hash)
    args.last[:host] ||= host
    args.last[:protocol] ||= protocol
    args.last[:folder] ||= folder
    sitemap = DynamicSitemaps::Sitemap.new(*args, &block)

    ensure_valid_sitemap_name! sitemap
    sitemap_names[sitemap.folder] << sitemap.name

    sitemaps << DynamicSitemaps::SitemapGenerator.new(sitemap).generate
  end

  def protocol(*args)
    if args.any?
      @protocol = args.first
      Rails.application.routes.default_url_options[:protocol] = @protocol
    else
      @protocol
    end
  end
end
