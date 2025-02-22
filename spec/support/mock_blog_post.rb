module MockBlogPost
  private

  def refresh_sitemap
    Rails.logger.info "🚀 Skipping sitemap refresh in tests."
  end
end

RSpec.configure do |config|
  config.before(:each) do
    BlogPost.prepend(MockBlogPost)
  end
end
