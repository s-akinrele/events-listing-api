require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let(:headers) { valid_headers }
  let!(:events) { create_list(:event, 10) }
  let(:event_id) { events.first.id }

  # Test suite for GET /events
  describe 'GET /events' do
    # make HTTP get request before each example
    before { get '/events', headers: headers }

    it 'returns events' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /events/:id
  describe 'GET /events/:id' do
    before { get "/events/#{event_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for POST /events
  describe 'POST /events' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', description: 'This is the first event', start_date: DateTime.now, end_date: 10.days.from_now } }

    context 'when the request is valid' do
      before { post '/events', params: valid_attributes, headers: headers.except("Content-Type") }

      it 'creates an event' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/events', params: { name: 'Foobar' }, headers: headers.except("Content-Type") }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /events/:id
  describe 'PUT /events/:id' do
    let(:valid_attributes) { { name: 'Introduction to React' } }

    context 'when the record exists' do
      before { put "/events/#{event_id}", params: valid_attributes, headers: headers.except("Content-Type") }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /events/:id
  describe 'DELETE /events/:id' do
    before { delete "/events/#{event_id}", headers: headers.except("Content-Type") }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
