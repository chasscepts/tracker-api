require 'rails_helper'
require 'json'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let!(:groups) { create_list(:group, 3) }
  let(:group_id) { groups.first.id }
  let(:tasks) do
    groups.reduce([]) { |accm, group| accm + create_list(:task, 2, group_id: group.id, user_id: user.id) }
  end
  let(:task_id) { tasks.first.id }

  before { tasks }

  describe 'GET /tasks' do
    before { get '/tasks', headers: headers }

    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(6)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the group' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe 'POST /tasks' do
    let(:valid_attributes) { { title: 'Task' } }

    context 'when the request is valid' do
      before { post "/groups/#{group_id}/tasks", params: valid_attributes.to_json, headers: headers }

      it 'creates a task' do
        expect(json['title']).to eq('Task')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/groups', params: { }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes.to_json, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
