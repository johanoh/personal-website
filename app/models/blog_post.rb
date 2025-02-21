class BlogPost < ApplicationRecord
  before_validation :generate_slug, if: :title_changed?
  before_save :set_published_at, if: :published?
  after_create :refresh_sitemap
  after_update :refresh_sitemap
  after_commit :refresh_sitemap, on: :destroy

  before_update :prevent_slug_change_if_published

  validates :title, presence: true
  validates :content, presence: true
  validates :slug, uniqueness: true, presence: true

  has_many :blog_post_tags, dependent: :destroy
  has_many :tags, through: :blog_post_tags

  scope :published, -> { where(published: true).where("published_at <= ?", Time.current) }
  scope :visible, -> { where(hidden: false) }

  def to_param
    slug
  end

  private

  def refresh_sitemap
    Rails.application.executor.wrap do
      system("rails sitemap:refresh")
    end
  end

  def generate_slug
    self.slug = title.parameterize if slug.blank?
  end

  def prevent_slug_change_if_published
    if published? && slug_changed?
      errors.add(:slug, "cannot be changed after publishing.")
      throw(:abort)
    end
  end

  def set_published_at
    self.published_at ||= Time.current if published?
  end
end
