require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let!(:blog_post) { BlogPost.create!(title: "Test Post", content: "Content", slug: "test-post", published: true, hidden: false) }

  describe "GET /show" do
    it "returns http success" do
      get blog_path(blog_post.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
