class Admin < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true
    validates :name, :email, :phone_number, :address, :credit_number, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    validates_confirmation_of :password
end
