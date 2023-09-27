class Admin < ApplicationRecord
    validates_confirmation_of :password
end
