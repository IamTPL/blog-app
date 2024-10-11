class Article < ApplicationRecord
  belongs_to :author
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 3, maximum: 30 }
end
