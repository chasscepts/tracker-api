require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let!(:groups) { create_list(:group, 3) }
  let(:group_id) { groups.first.id }

  describe 'POST /auth' do
    let(:valid_attributes) { { email: 'test@example.com', password: 'qqqqqq' } }

    context 'when the request is valid' do
      before { post '/auth', params: valid_attributes }

      it 'creates a group' do
        expect(json['title']).to eq('Test Group')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/groups', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end
end
