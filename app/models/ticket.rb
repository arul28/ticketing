class Ticket < ApplicationRecord
    belongs_to :train
    belongs_to :passenger
    before_create :generate_confirmation_number
  
    private
  
    def generate_confirmation_number
      self.confirmation_number = generate_unique_confirmation_number
    end
    
  
    def generate_unique_confirmation_number
        length = 8
        characters = '0123456789'
        confirmation_number = ''
        loop do
          length.times { confirmation_number << characters[rand(characters.length)] }
          break confirmation_number unless Ticket.exists?(confirmation_number: confirmation_number.to_i)
        end
        confirmation_number.to_i
      end
    
end
