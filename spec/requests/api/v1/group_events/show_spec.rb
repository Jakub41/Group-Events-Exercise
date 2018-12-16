require 'rails_helper'

describe 'GET api/v1/group_event/:id', type: :request do
  let(:group_event) { create(:group_event) }
  subject           { get api_v1_group_event_path(id: group_event.id), as: :json }

  before(:each) { subject }

  it { expect(response).to be_successful }

  it 'returns group event data' do
    data = json[:group_event]

    expect(data[:id]).to eq group_event.id
    expect(data[:name]).to eq group_event.name
    expect(data[:description]).to eq group_event.description
    expect(data[:status]).to eq group_event.status
    expect(data[:start_date]).to eq group_event.start_date.iso8601
    expect(data[:end_date]).to eq group_event.end_date.iso8601
    expect(data[:duration]).to eq group_event.duration
    expect(data[:latitude]).to eq group_event.latitude.to_s
    expect(data[:longitude]).to eq group_event.longitude.to_s
  end
end
