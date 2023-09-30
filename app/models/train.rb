class Train < ApplicationRecord
    has_many :reviews
    has_many :tickets
end
