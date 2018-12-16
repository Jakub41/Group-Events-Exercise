require 'rails_helper'

describe 'GET api/v1/group_events', type: :request do
  subject { get api_v1_group_events_path(page: page), as: :json }

  before(:each) do
    30.times { create(:group_event) }
    subject
  end

  context 'when the first page is requested' do
    let(:page) { 1 }

    it { expect(response).to be_successful }

    it 'returns the first 25 group events' do
      json[:group_events].count eq 25
    end

    it 'returns group events data' do
      data = json[:group_events][0]

      expect(data[:id]).to be_truthy
      expect(data[:name]).to be_truthy
      expect(data[:description]).to be_truthy
      expect(data[:status]).to be_truthy
      expect(data[:start_date]).to be_truthy
      expect(data[:end_date]).to be_truthy
      expect(data[:duration]).to be_truthy
      expect(data[:latitude]).to be_truthy
      expect(data[:longitude]).to be_truthy
    end
  end

  context 'when the second page is requested' do
    let(:page) { 2 }

    it { expect(response).to be_successful }

    it 'returns the last 5 group events' do
      json[:group_events].count eq 5
    end
  end
end
