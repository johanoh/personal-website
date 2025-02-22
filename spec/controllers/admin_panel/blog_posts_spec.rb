require "rails_helper"

RSpec.describe AdminPanel::BlogPostsController, type: :request do
  let!(:admin) { Admin.create!(email: "admin@example.com", password: "password") }
  let!(:blog_post) { BlogPost.create!(title: "Test Post", content: "Test content", slug: "test-post", published: false, hidden: true) }

  before do
    sign_in admin, scope: :admin
  end

  describe "GET #index" do
    it "renders the index page successfully" do
      get admin_panel_blog_posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "renders the new post form" do
      get new_admin_panel_blog_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new blog post" do
        expect {
          post admin_panel_blog_posts_path, params: { blog_post: { title: "New Post", content: "New Content", slug: "new-post" } }
        }.to change(BlogPost, :count).by(1)

        expect(response).to redirect_to(admin_panel_blog_posts_path) # Ensure redirect
        follow_redirect! # Follow the redirect to index

        expect(flash[:notice]).to eq("Blog post created successfully!") # Assert flash message
      end
    end

    context "with invalid attributes" do
      it "does not create a new blog post" do
        expect {
          post admin_panel_blog_posts_path, params: { blog_post: { title: "", content: "", slug: "" } }
        }.not_to change(BlogPost, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit page" do
      get edit_admin_panel_blog_post_path(blog_post.slug)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the blog post" do
        patch admin_panel_blog_post_path(blog_post.slug), params: { blog_post: { title: "Updated Title" } }
        expect(response).to redirect_to(admin_panel_blog_posts_path)
        blog_post.reload
        expect(blog_post.title).to eq("Updated Title")
      end
    end

    context "with invalid attributes" do
      it "does not update the blog post" do
        patch admin_panel_blog_post_path(blog_post.slug), params: { blog_post: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the blog post" do
      expect {
        delete admin_panel_blog_post_path(blog_post.slug)
      }.to change(BlogPost, :count).by(-1)

      expect(response).to redirect_to(admin_panel_blog_posts_path)
    end
  end

  describe "POST #toggle_publish" do
    it "toggles the published status" do
      patch toggle_publish_admin_panel_blog_post_path(blog_post.slug)
      blog_post.reload
      expect(blog_post.published).to be true
    end
  end

  describe "POST #toggle_hidden" do
    it "toggles the hidden status" do
      patch toggle_hidden_admin_panel_blog_post_path(blog_post.slug)
      blog_post.reload
      expect(blog_post.hidden).to be false
    end
  end
end
