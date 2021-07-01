class User < ApplicationRecord
mount_uploader :avatar, AvatarUploader
validates_integrity_of  :avatar
  validates_processing_of :avatar
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
   validates :email, presence: true, length: { maximum: 255 },
                     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
                     has_secure_password
                       validates :password, presence: true, length: { minimum: 6 }
has_many :posts
has_many :favorites, dependent: :destroy
  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
