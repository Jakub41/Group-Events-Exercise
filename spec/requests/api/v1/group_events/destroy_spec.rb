require 'rails_helper'

describe 'DELETE api/v1/group_event/:id', type: :request do
  let(:group_event) { create(:group_event) }
  subject           { delete api_v1_group_event_path(id: group_event.id), as: :json }

  before(:each) { subject }

  it { expect(response).to be_successful }

  it 'sets the deleted_at of the group_event' do
    expect(group_event.reload.deleted_at).to be_within(5.seconds).of Time.zone.now
  end
end
