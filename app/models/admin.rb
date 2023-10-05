class Admin < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true
    validates :name, :email, :phone_number, :address, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :credit_number, length: { is: 16, message: "must be 16 digits long" }, numericality: { only_integer: true, message: "must only contain digits" }

    validates_confirmation_of :password
end
