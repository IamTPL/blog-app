class Article < ApplicationRecord
  belongs_to :author
  has_one :article_detail, dependent: :destroy
  accepts_nested_attributes_for :article_detail
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 3, maximum: 50 }
end
