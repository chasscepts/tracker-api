# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) { { email: user.email, password: user.password } }

  # User signup test suite
  describe 'POST /register' do
    context 'when valid request' do
      before do
        create_list(:group, 3).each { |group| create_list(:default_task, 2, group_id: group.id) }
        post '/auth/register', params: valid_attributes.to_json, headers: headers
      end

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'does not return authentication token' do
        expect(json['auth_token']).to be_nil
      end

      it 'returns user email' do
        expect(json['email']).to eq(user.email)
      end
    end

    context 'when invalid request' do
      before { post '/auth/register', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Email has already been taken/)
      end
    end
  end
end