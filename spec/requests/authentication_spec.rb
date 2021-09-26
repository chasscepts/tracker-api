require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user) }
  let(:token) { token_generator(user.id) }

  context 'authenticates user with valid credential' do
    let(:valid_attributes) { { email: user.email, password: user.password } }
    before { post '/auth', params: valid_attributes }

    it 'returns user email in response' do
      expect(json['user']['email']).to eq(user.email)
    end

    it 'returns user token in password' do
      expect(json['user']['token']).to eq(token)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'fails when credentials are invalid' do
    let(:invalid_attributes) { { email: user.email, password: "#{user.password}invalid" } }
    before { post '/auth', params: invalid_attributes }

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end
end
