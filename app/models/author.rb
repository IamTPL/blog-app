class Author < ApplicationRecord
  has_secure_password
  before_save { self.email = email.strip.downcase }
  has_many :articles, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 3, maximum: 25 }
  validates :password_confirmation, presence: true, if: :password_required?

  # Yêu cầu mật khẩu chỉ khi mật khẩu được nhập hoặc khi tạo mới (new_record?)
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  # add method digest to test controllers
  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(password, cost:)
  end

  def to_s
    name.to_s
  end
end
