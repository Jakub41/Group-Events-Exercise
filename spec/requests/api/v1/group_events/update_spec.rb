require 'rails_helper'

describe 'PUT api/v1/group_event/:id', type: :request do
  let(:group_event) { create(:group_event, start_date: Date.today + 1.day) }
  subject           { put api_v1_group_event_path(id: group_event.id), params: params, as: :json }

  before(:each) { subject }

  context 'with valid params' do
    let(:params) do
      {
        name: 'New Name',
        description: 'New description',
        end_date: Date.today + 100.day,
        duration: 99
      }
    end

    it { expect(response).to be_successful }

    it 'returns group event data updated' do
      data = json[:group_event]

      expect(data[:id]).to eq group_event.id
      expect(data[:name]).to eq 'New Name'
      expect(data[:description]).to eq 'New description'
      expect(data[:status]).to eq group_event.status
      expect(data[:start_date]).to eq group_event.start_date.iso8601
      expect(data[:end_date]).to eq (Date.today + 100.day).iso8601
      expect(data[:duration]).to eq 99
      expect(data[:latitude]).to eq group_event.latitude.to_s
      expect(data[:longitude]).to eq group_event.longitude.to_s
    end
  end

  context 'with invalid params' do
    let(:params) do
      {
        name: 'New Name',
        description: 'New description',
        end_date: Date.today + 100.day
      }
    end

    it { expect(response).to have_http_status(400) }

    it 'returns an error' do
      expect(json[:errors]).to eq ['Duration is not correct']
    end
  end
end
