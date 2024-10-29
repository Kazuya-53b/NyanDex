class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :user_id, uniqueness: { scope: :cat_id }
end
