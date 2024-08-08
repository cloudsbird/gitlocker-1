class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_one_attached :image

  validate :content_word_count
  validates :slug, presence: true, uniqueness: true

  def content_word_count
    if content.present? && content.split.size > 2500
      errors.add(:content, "should not exceed 2500 words")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "content","slug", "created_at", "updated_at"]
  end
end
