class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.boolean :hidden
      t.datetime :published_at
      t.boolean :published

      t.timestamps
    end
    add_index :blog_posts, :slug, unique: true
  end
end
