require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:review) { create(:review) }

    it 'returns a successful response' do
      get :show, params: { id: review.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    let(:review) { create(:review) }

    it 'returns a successful response' do
      get :edit, params: { id: review.id }
      expect(response).to be_successful
    end
  end
end
