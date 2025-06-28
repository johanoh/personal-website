class BlogController < ApplicationController
  def index
    @blog_posts = BlogPost.published.visible.order(published_at: :desc)
    @blog_posts = @blog_posts.by_tag(params[:tag]) if params[:tag]
  end

  def show
    @blog_post = BlogPost.published.visible.find_by!(slug: params[:slug])
  end
end
