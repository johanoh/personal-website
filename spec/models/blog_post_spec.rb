require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  let(:blog_post) { BlogPost.new(title: "Test Title", content: "Some content") }

  ## 🛠 **Validations**
  describe "validations" do
    it "is valid with a title, content, and slug" do
      blog_post.valid?
      expect(blog_post).to be_valid
    end

    it "is invalid without a title" do
      blog_post.title = nil
      expect(blog_post).not_to be_valid
      expect(blog_post.errors[:title]).to include("can't be blank")
    end

    it "is invalid without content" do
      blog_post.content = nil
      expect(blog_post).not_to be_valid
      expect(blog_post.errors[:content]).to include("can't be blank")
    end

    it "is invalid without a slug" do
      blog_post.title = nil
      blog_post.slug = nil
      blog_post.valid?
      expect(blog_post.errors[:slug]).to include("can't be blank")
    end


    it "is invalid if the slug is not unique" do
      BlogPost.create!(title: "Original Title", content: "Content", slug: "duplicate-slug")
      duplicate = BlogPost.new(title: "Another Title", content: "More Content", slug: "duplicate-slug")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:slug]).to include("has already been taken")
    end
  end

  ## 🏷 **Slug Generation**
  describe "slug generation" do
    it "generates a slug from the title if blank" do
      blog_post.slug = nil
      blog_post.valid?
      expect(blog_post.slug).to eq("test-title")
    end

    it "does not overwrite an existing slug" do
      blog_post.slug = "custom-slug"
      blog_post.valid?
      expect(blog_post.slug).to eq("custom-slug")
    end
  end

  describe "preventing slug change if published" do
    it "allows changing the slug if unpublished" do
      blog_post.published = false
      blog_post.slug = "new-slug"
      expect(blog_post).to be_valid
    end

    it "prevents changing the slug after publishing" do
      blog_post.update!(published: true, slug: "original-slug")

      expect {
        blog_post.update!(slug: "new-slug")
      }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end

  describe "published_at timestamp" do
    it "sets published_at when published is true" do
      blog_post.published = true
      blog_post.save!
      expect(blog_post.published_at).not_to be_nil
    end

    it "does not change published_at if already set" do
      timestamp = 2.days.ago
      blog_post.update!(published_at: timestamp, published: true)
      expect(blog_post.published_at.to_i).to eq(timestamp.to_i)
    end
  end

  describe "scopes" do
    before do
      @published_post = BlogPost.create!(title: "Published Post", content: "Content", published: true, published_at: 1.day.ago)
      @hidden_post = BlogPost.create!(title: "Hidden Post", content: "Content", published: true, hidden: true, published_at: 1.day.ago)
      @future_post = BlogPost.create!(title: "Future Post", content: "Content", published: true, published_at: 2.days.from_now)
    end

    it "includes only published and past-dated posts in `published` scope" do
      expect(BlogPost.published).to include(@published_post)
      expect(BlogPost.published).not_to include(@future_post)
    end

    it "excludes hidden posts in `visible` scope" do
      expect(BlogPost.visible).not_to include(@hidden_post)
    end
  end

  describe "sitemap refresh" do
    before do
      allow(blog_post).to receive(:refresh_sitemap)
    end

    it "refreshes sitemap after create" do
      expect(blog_post).to receive(:refresh_sitemap).once
      blog_post.save!
    end

    it "refreshes sitemap after update" do
      blog_post.save!
      expect(blog_post).to receive(:refresh_sitemap).once
      blog_post.update!(title: "Updated Title")
    end

    it "refreshes sitemap after destroy" do
      blog_post.save!
      expect(blog_post).to receive(:refresh_sitemap).once
      blog_post.destroy!
    end
  end
end
