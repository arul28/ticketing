# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:rating).in_array([1, 2, 3, 4, 5]).with_message('Rating must be between 1 and 5') }
  end

  describe 'associations' do
    it { should belong_to(:train) }
    it { should belong_to(:passenger) }
  end
end

