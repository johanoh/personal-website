class BlogController < ApplicationController
  def index
    if params[:tag]
      tag = Tag.find_by(name: params[:tag])
      @blog_posts = tag ? tag.blog_posts.published.visible.order(published_at: :desc) : []
    else
      @blog_posts = BlogPost.published.visible.order(published_at: :desc)
    end
  end

  def show
    @blog_post = BlogPost.published.visible.find_by!(slug: params[:slug])
  end
end
