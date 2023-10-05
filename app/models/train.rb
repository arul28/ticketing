class Train < ApplicationRecord

    has_many :reviews, dependent: :destroy
    has_many :tickets, dependent: :destroy

    has_many :passengers, through: :tickets
    validates :number_of_seats_left, numericality: { greater_than_or_equal_to: 0 }
end
