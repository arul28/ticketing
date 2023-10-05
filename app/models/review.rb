class Review < ApplicationRecord
    validates :rating, inclusion: { in: [1, 2, 3, 4, 5], message: "Rating must be between 1 and 5" }

    belongs_to :train
    belongs_to :passenger
end
