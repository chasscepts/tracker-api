require 'rails_helper'
require 'json'

RSpec.describe 'Groups', type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let!(:groups) { create_list(:group, 3) }
  let(:group_id) { groups.first.id }

  describe 'GET /groups' do
    before { get '/groups', headers: headers }

    it 'returns groups' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /groups/:id' do
    before { get "/groups/#{group_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the group' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(group_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:group_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Group/)
      end
    end
  end

  describe 'POST /groups' do
    let(:valid_attributes) { { title: 'Test Group' } }

    context 'when the request is valid' do
      before { post '/groups', params: valid_attributes.to_json, headers: headers }

      it 'creates a group' do
        expect(json['title']).to eq('Test Group')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/groups', params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /groups/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/groups/#{group_id}", params: valid_attributes.to_json, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /groups/:id' do
    before { delete "/groups/#{group_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
