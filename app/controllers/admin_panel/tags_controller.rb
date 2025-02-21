module AdminPanel
  class TagsController < ApplicationController
    before_action :authenticate_admin!

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        redirect_to admin_panel_blog_posts_path, notice: "Tag created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end
  end
end
