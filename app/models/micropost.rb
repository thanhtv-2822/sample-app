class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.microposts.size_content}
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png)},
    size: {
      less_than: Settings.length.size_mb.megabytes,
      message: "should be less than 5MB"
    }

  def display_image
    image.variant resize_to_limit: [Settings.img.resize, Settings.img.resize]
  end
end
