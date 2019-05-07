require 'rails_helper'

RSpec.describe 'Messages API', type: :request do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:messages) { create_list(:message, 10, user_id: user.id, from_user_id: another_user.id) }
  let!(:other_messages) { create_list(:message, 10, user_id: another_user.id, from_user_id: user.id) }
  let(:message_id) { messages.first.id }
  let(:another_users_message_id) { other_messages.first.id }
  let(:headers) { valid_headers }

  describe 'GET /messages' do
    before { get '/messages', params: {}, headers: headers }

    it 'returns messages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns only messages that belong to the authenticated user' do
      json.each do |msg|
        expect(msg['user_id']).to eq(user.id)
      end
    end
  end

  describe 'GET /messages/:id' do
    before { get "/messages/#{message_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the message' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(message_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when requesting another users messages' do
      let(:message_id) { another_users_message_id }
      it 'returns an empty array' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the record does not exist' do
      let (:message_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end    
  end

  describe 'POST /messages' do
    let (:valid_attributes) do
      { body: 'Hello World', user_id: user.id.to_s, from_user_id: another_user.id.to_s}.to_json
    end

    context 'when the request is valid' do
      before { post '/messages', params: valid_attributes, headers: headers }

      it 'creates a message' do
        expect(json['body']).to eq('Hello World')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/messages', params: { body: 'Hello World' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end

    describe 'PUT /messages/:id' do
      let (:valid_attributes) { { body: 'Goodbye World' }.to_json }

      context 'when the record exists' do
        before { put "/messages/#{message_id}", params: valid_attributes, headers: headers }

        context 'when the user does not own the message' do
          let (:message_id) { another_users_message_id }

          it 'returns a 404' do
            expect(response).to have_http_status(404)
          end
        end

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns a status code 204' do
          expect(response).to have_http_status(204)
        end
      end      
    end

    describe 'DELETE /messages/:id' do
      before { delete "/messages/#{message_id}", params: {}, headers: headers }

      context 'when the user does not own the message' do
        let (:message_id) { another_users_message_id }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when the user owns the message' do
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end
  end
end
