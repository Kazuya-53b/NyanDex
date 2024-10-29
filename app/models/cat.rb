class Cat < ApplicationRecord
  belongs_to :user

  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  mount_uploaders :images, ImageUploader

  private

  def must_have_images
    if images.blank? || images.size < 1
      errors.add(:images, "少なくとも1枚の画像をアップロードしてください。")
    end
  end
end
