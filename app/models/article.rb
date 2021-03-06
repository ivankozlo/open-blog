class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 }
  validates :user_id, presence: true
end
