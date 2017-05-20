# spec/requests/profiles_spec.rb
require 'rails_helper'

RSpec.describe 'Profiles API', type: :request do
  # initialize test data 
  let!(:profiles) { create_list(:profile, 10) }
  let(:profile_id) { profiles.first.id }

  # Test suite for GET /profiles
  describe 'GET /profiles' do
    # make HTTP get request before each example
    before { get '/profiles' }

    it 'returns profiles' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /profiles/:id
  describe 'GET /profiles/:id' do
    before { get "/profiles/#{profile_id}" }

    context 'when the record exists' do
      it 'returns the profile' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(profile_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:profile_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Profile/)
      end
    end
  end

  # Test suite for POST /profiles
  describe 'POST /profiles' do
    # valid payload
    let(:valid_attributes) { { firstname: 'Learn Elm', lastname: '1' } }

    context 'when the request is valid' do
      before { post '/profiles', params: valid_attributes }

      it 'creates a profile' do
        expect(json['firstname']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/profiles', params: { firstname: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Lastname can't be blank/)
      end
    end
  end

  # Test suite for PUT /profiles/:id
  describe 'PUT /profiles/:id' do
    let(:valid_attributes) { { firstname: 'Shopping' } }

    context 'when the record exists' do
      before { put "/profiles/#{profile_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /profiles/:id
  describe 'DELETE /profiles/:id' do
    before { delete "/profiles/#{profile_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end