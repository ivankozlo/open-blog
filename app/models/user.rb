class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase } # Enforces all email addresses to low cases
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX, message: 'Invalid email format' }
  has_secure_password
end
