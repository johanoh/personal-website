class SitemapRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.application.executor.wrap do
      system("rails sitemap:refresh")
    end
  end
end
