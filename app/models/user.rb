class User < ApplicationRecord
  has_many :users_props, class_name: "UsersProp"
  has_many :properties, through: :users_props

  has_secure_password
  has_secure_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, uniqueness: true, allow_nil: true
  validates :password, length: { minimum: 6 }, if: :password_required?

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: "Only allows a valid email" }
  enum role: { home_seeker: 0, landlord: 1 }

  def invalidate_token
    update(token: nil)
  end

  def password_required?
    password.present? || !persisted?
  end
end
