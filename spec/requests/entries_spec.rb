require 'rails_helper'

RSpec.describe 'Entries API', type: :request, focus: :true do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:partner) { create(:user) }
  let!(:entries) { create_list(:entry, 20, user_id: user.id, linked_user_id: partner.id) }
  let(:user_id) { user.id }
  let(:id) { entries.first.id }

  # Test suite for GET /profiles/:profile_id/entries
  describe 'GET entries' do
    before do
      @auth_headers = user.create_new_auth_token
      get '/entries', params: {}, headers: @auth_headers
    end

    context 'when entries exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all profile entries' do
        expect(json.size).to eq(20)
      end
    end

  end

  # Test suite for POST /todos
  describe 'POST /entries' do
    # valid payload
    let(:valid_attributes) { { content: 'Learn Elm', created_by: user_id, linked_user_id: partner.id } }

    before do
      @auth_headers = user.create_new_auth_token

    end


    context 'when the request is valid' do
      before {post '/entries', params: valid_attributes, headers: @auth_headers}
      it 'creates a entry' do
        expect(json['content']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/entries', params: {}, headers: @auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Content can't be blank/)
      end
    end
  end
end