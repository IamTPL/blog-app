class ArticleDetail < ApplicationRecord
  belongs_to :article
  validates :word_count, presence: true, numericality: { only_integer: true }
  validates :topic, presence: true, length: { minimum: 3, maximum: 20 }
  validates :published_at, presence: true
end
