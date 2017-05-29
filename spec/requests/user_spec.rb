require 'rails_helper'

RSpec.describe 'Authentication', type: :request, focus: :true do


  context 'user signed in' do
    describe 'GET #current' do
      before do
        @user = FactoryGirl.create :user
      end

      it 'Should respond with status 200(OK)' do
        # we are not using confirmation right now
        # @user.confirm

        @auth_headers = @user.create_new_auth_token
        get '/entries', params: {}, headers: @auth_headers
        expect(response).to have_http_status(:success)
      end

      #TODO: add this test once we figure out why this route doesn't work.
      # it 'Should respond with user details' do
      #   @auth_headers = @user.create_new_auth_token
      #   get '/auth/edit', params: {}, headers: @auth_headers
      # end
    end
  end

  describe 'POST /auth (Sign Up process)' do
    it 'Should respond with status 200(OK)' do
      post user_registration_path(:name => 'Test User', :email => 'email@email.com', :password => 'qwertyuiop')
      expect(response).to have_http_status(200)
    end

    it 'Should respond with status 200(OK)' do
      expect{
        post user_registration_path(:email => 'email@email.com', :password => 'qwertyuiop')
      }.to change(User, :count).by(1)
    end

    it 'Should respond with status success' do
      post user_registration_path(:name => 'Test User', :email => 'email@email.com', :password => 'qwertyuiop')
      expect(response).to have_http_status(200)
    end

    it 'Should respond with name)' do
      post user_registration_path(:name => 'Test User', :email => 'email@email.com', :password => 'qwertyuiop')
      expect(json['data']['name']).to match('Test User')
    end

    it 'Should respond with nickname)' do
      post user_registration_path(:nickname => 'Test User', :email => 'email@email.com', :password => 'qwertyuiop')
      expect(json['data']['nickname']).to match('Test User')
    end

    it 'Should respond with email)' do
      post user_registration_path(:name => 'Test User', :email => 'email@email.com', :password => 'qwertyuiop')
      expect(json['data']['email']).to match('email@email.com')
    end

  end

  # describe 'POST /auth/confirmation (Confirmation process)' do
  #   it 'Should respond with status 302(URL redirection)' do
  #     # Sign Up
  #     post user_registration_path(:email => 'email@email.com', :password => 'qwertyuiop')
  #     # Email Confirmation
  #     user = User.last
  #     get user_confirmation_path(:config => 'default', :confirmation_token => user.confirmation_token, :redirect_url => '/')
  #     expect(response).to be_redirect
  #     #expect(response).to have_http_status(302)
  #   end
  # end

end