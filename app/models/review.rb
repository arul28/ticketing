class Review < ApplicationRecord
    belongs_to :train
    belongs_to :passenger
end
