DynamicSitemaps::Sitemap.class_eval do
  attr_reader :name, :collection, :block, :host, :folder, :protocol
  
  def initialize(*args, &block)
    if args.first.is_a?(Symbol)
      @name = args.shift
    end

    if args.last.is_a?(Hash)
      options = args.pop
      @per_page = options[:per_page]
      @protocol = options[:protocol]
      @host = options[:host]
      @folder = options[:folder]
      @collection = options[:collection]
    end

    @block = block
  end

  def root_url
    "#{protocol}://#{host}"
  end

  def protocol
    @protocol ||= DynamicSitemaps.protocol
  end
end
