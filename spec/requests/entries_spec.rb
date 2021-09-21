require 'rails_helper'
require 'json'

RSpec.describe "Entry", type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let!(:group) { create(:group) }
  let(:task) { create(:task, group_id: group.id, user_id: user.id) }
  let(:entry) { create(:entry, task_id: task.id) }
  let(:id) { entry.id }

  describe 'PUT /entries/:id' do
    let(:valid_attributes) { { duration: 100 } }

    context 'when the record exists' do
      before { put "/entries/#{id}", params: valid_attributes.to_json, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /entries/:id' do
    before { delete "/entries/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
