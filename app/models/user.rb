class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :profile_image, ProfileImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :cats, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_cats, through: :bookmarks, source: :cat

  validates :username, presence: true, length: { maximum: 12 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def password_required?
    new_record? || password.present?
  end

  def cats
    super.order(created_at: :desc)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def bookmark(cat)
    bookmark_cats << cat
  end
  
  def unbookmark(cat)
    bookmark_cats.destroy(cat)
  end
  
  def bookmark?(cat)
    bookmark_cats.include?(cat)
  end
end
