Rails.application.config.to_prepare do
  if defined?(SitemapGenerator::Sitemap)
    SitemapGenerator::Sitemap.define_singleton_method(:ping_search_engines) do |*args|
      Rails.logger.info "🚀 Sitemap pinging is permanently disabled."
    end
  end
end
