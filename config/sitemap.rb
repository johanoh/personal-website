# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://me.johanoh.ca"

SitemapGenerator::Sitemap.create do
  add root_path, changefreq: "daily", priority: 1.0
  add about_path, changefreq: "monthly", priority: 0.5
  add contact_path, changefreq: "monthly", priority: 0.5
  add blog_index_path, changefreq: "daily", priority: 1.0
  add projects_index_path, changefreq: "weekly", priority: 0.5

  BlogPost.published.find_each do |post|
      add blog_path(slug: post.slug), lastmod: post.updated_at, changefreq: "monthly", priority: 0.7
    end
  end


# Put links creation logic here.
#
# The root path '/' and sitemap index file are added automatically for you.
# Links are added to the Sitemap in the order they are specified.
#
# Usage: add(path, options={})
#        (default options are used if you don't specify)
#
# Defaults: :priority => 0.5, :changefreq => 'weekly',
#           :lastmod => Time.now, :host => default_host
#
# Examples:
#
# Add '/articles'
#
#   add articles_path, :priority => 0.7, :changefreq => 'daily'
#
# Add all articles:
#
#   Article.find_each do |article|
#     add article_path(article), :lastmod => article.updated_at
#   end
