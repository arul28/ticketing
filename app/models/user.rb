class User < ApplicationRecord
  has_secure_password

  validates :name, :email, :phone_number, :address, :credit_card, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_confirmation_of :password
end
