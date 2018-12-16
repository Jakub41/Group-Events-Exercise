require 'rails_helper'

describe 'POST api/v1/group_events', type: :request do
  subject       { post api_v1_group_events_path, params: params, as: :json }
  before(:each) { subject }

  context 'with valid params' do
    let(:params) do
      {
        name: 'Name',
        description: 'Description',
        status: GroupEvent.statuses[:published],
        start_date: Date.today + 1.day,
        end_date: Date.today + 10.day,
        latitude: 56,
        longitude: 34
      }
    end

    it { expect(response).to be_successful }

    it 'returns group event data' do
      data = json[:group_event]

      expect(data[:id]).to be_truthy
      expect(data[:name]).to eq 'Name'
      expect(data[:description]).to eq 'Description'
      expect(data[:status]).to eq 'published'
      expect(data[:start_date]).to eq (Date.today + 1.day).iso8601
      expect(data[:end_date]).to eq (Date.today + 10.day).iso8601
      expect(data[:duration]).to eq 9
      expect(data[:latitude]).to eq '56.0'
      expect(data[:longitude]).to eq '34.0'
    end
  end

  context 'with invalid params' do
    let(:params) do
      {
        name: 'Name',
        description: 'Description',
        start_date: Date.today + 1.day,
        end_date: Date.today + 10.day,
        status: GroupEvent.statuses[:published]
      }
    end

    it { expect(response).to have_http_status(400) }

    it 'returns an error' do
      expect(json[:errors]).to eq ['Latitude can\'t be blank', 'Longitude can\'t be blank']
    end
  end
end
