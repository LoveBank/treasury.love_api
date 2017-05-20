require 'rails_helper'

RSpec.describe 'Entries API' do
  # Initialize the test data
  let!(:profile) { create(:profile) }
  let!(:entries) { create_list(:entry, 20, profile_id: profile.id) }
  let(:profile_id) { profile.id }
  let(:id) { entries.first.id }

  # Test suite for GET /profiles/:profile_id/entries
  describe 'GET /profiles/:profile_id/entries' do
    before { get "/profiles/#{profile_id}/entries" }

    context 'when profile exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all profile entries' do
        expect(json.size).to eq(20)
      end
    end

    context 'when profile does not exist' do
      let(:profile_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Profile with 'id'=0/)
      end
    end
  end

  # Test suite for GET /profiles/:profile_id/entries/:id
  describe 'GET /profiles/:profile_id/entries/:id' do
    before { get "/profiles/#{profile_id}/entries/#{id}" }

    context 'when profile item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when profile item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Entry/)
      end
    end
  end

  # Test suite for PUT /entries/:profile_id/entries
  describe 'POST /profiles/:profile_id/entries' do
    let(:valid_attributes) { { content: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/profiles/#{profile_id}/entries", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/profiles/#{profile_id}/entries", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  # Test suite for PUT /entries/:profile_id/entries/:id
  describe 'PUT /profiles/:profile_id/entries/:id' do
    let(:valid_attributes) { { content: 'Mozart' } }

    before { put "/profiles/#{profile_id}/entries/#{id}", params: valid_attributes }

    context 'when entry exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

    end

    context 'when the entry does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Entry/)
      end
    end
  end

  # Test suite for DELETE /entries/:id
  describe 'DELETE /entries/:id' do
    before { delete "/profiles/#{profile_id}/entries/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end