module AdminPanel
  class BlogPostsController < ApplicationController
    before_action :authenticate_admin

    before_action :disable_turbo, only: [ :new, :edit, :create, :update ]

    def index
      @blog_posts = BlogPost.order(published_at: :desc)
    end

    def new
      @blog_post = BlogPost.new
    end

    def create
      @blog_post = BlogPost.new(blog_post_params)
      @blog_post.hidden = true
      if @blog_post.save
        redirect_to admin_panel_blog_posts_path, notice: "Blog post created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @blog_post = BlogPost.find_by(slug: params[:slug])
    end

    def update
      @blog_post = BlogPost.find_by(slug: params[:slug])

      if @blog_post.update(blog_post_params)
        redirect_to admin_panel_blog_posts_path, notice: "Blog post updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @blog_post = BlogPost.find_by(slug: params[:slug])
      if @blog_post.destroy
        redirect_to admin_panel_blog_posts_path, notice: "Blog post deleted successfully!"
      else
        redirect_to admin_panel_blog_posts_path, alert: "Failed to delete blog post."
      end
    end

    def toggle_publish
      @blog_post = BlogPost.find_by(slug: params[:slug])
      @blog_post.update(published: !@blog_post.published)
      redirect_to admin_panel_blog_posts_path
    end

    def toggle_hidden
      @blog_post = BlogPost.find_by(slug: params[:slug])
      @blog_post.update(hidden: !@blog_post.hidden)
      redirect_to admin_panel_blog_posts_path
    end

    private

    def blog_post_params
      params.require(:blog_post).permit(:title, :content, :slug, tag_ids: [])
    end

    def disable_turbo
      response.headers["Turbo-Frame"] = "false"
    end

    def authenticate_admin
      redirect_to new_admin_session_path, alert: "You must be an admin to access this page." unless current_admin
    end
  end
end
