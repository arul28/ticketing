class Passenger < ApplicationRecord
  has_secure_password

  validates :name, :email, :phone_number, :address, :credit_card, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_confirmation_of :password

  has_many :reviews, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :trains, through: :tickets
end
