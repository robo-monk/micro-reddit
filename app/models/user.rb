class User < ApplicationRecord
  has_many :posts
  has_many :comments
  before_save { name.downcase! }
  before_save { email.downcase! }
  validates :name,
              presence: true,
              uniqueness: { case_sensitive: false },
              length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

end
