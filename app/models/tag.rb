class Tag < ApplicationRecord
  has_many :blog_post_tags, dependent: :destroy
  has_many :blog_posts, through: :blog_post_tags

  validates :name, presence: true, uniqueness: true
end
