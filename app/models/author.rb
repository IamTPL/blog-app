class Author < ApplicationRecord
  has_secure_password
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 3, maximum: 25 }
  validates :password_confirmation, presence: true
  def to_s
    name.to_s
  end
end
