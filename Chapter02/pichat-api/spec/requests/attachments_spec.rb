require 'rails_helper'

RSpec.describe 'Attachments API' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:message) { create(:message, user_id: user.id, from_user_id: another_user.id) }
  let!(:attachments) { create_list(:attachment, 20, message: message) }
  let(:message_id) { message.id }
  let(:id) { attachments.first.id }
  let(:headers) { valid_headers }

  describe 'GET /messages/:message_id/attachments' do
    before { get "/messages/#{message_id}/attachments", params: {}, headers: headers }

    context 'when message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a list of attachments' do
        expect(json).not_to be_empty
        expect(json.size).to eq(20)
      end
    end

    context 'when message does not exist' do
      let (:message_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
    
  end

  describe 'GET /messages/:message_id/attachments/:id' do
    before { get "/messages/#{message_id}/attachments/#{id}", params: {}, headers: headers }

    context 'when attachment exists' do

      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the attachment' do
        expect(json['id']).to eq(id)
      end
      
    end

    context 'when the attachment does not exist' do
      let (:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Attachment/)
      end
    end
  end
  
  describe 'POST /messages/:message_id/attachments' do
    let(:files) { double("file", :create => double("newfile", :public_url => 'http://url/file')) }

    let(:valid_attributes) do
      { media_type: 1, file: { name: 'foo', data: 'fdsafds' } }.to_json
    end

    context 'when request attributes are valid' do
      before do
        StorageBucket = double("Book", :files => files)
        post "/messages/#{message_id}/attachments", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/messages/#{message_id}/attachments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Invalid file data/)
      end
    end    
  end

  describe 'DELETE /messages/:message_id/attachments/:id' do
    before { delete "/messages/#{message_id}/attachments/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
  
end
