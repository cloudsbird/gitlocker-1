class Blog < ApplicationRecord
  has_one_attached :image

  validates :content, length: { maximum: 2500, message: "Content should not exceed 2500 characters" }

  def self.ransackable_attributes(auth_object = nil)
    ["title", "content", "created_at", "updated_at"]
  end
end
