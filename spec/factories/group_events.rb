# == Schema Information
#
# Table name: group_events
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  start_date  :date
#  end_date    :date
#  duration    :integer
#  status      :integer          default("draft")
#  latitude    :decimal(10, 6)
#  longitude   :decimal(10, 6)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :group_event do
    name        { Faker::Name.name }
    description { Faker::Lorem.sentence(6) }
    start_date  { Date.today + 1.day }
    end_date    { Date.today + 10.day }
    status      { GroupEvent.statuses[:published] }
    latitude    { Faker::Address.latitude }
    longitude   { Faker::Address.longitude }

    trait :draft do
      status { GroupEvent.statuses[:draft] }
    end

    trait :empty_draft do
      name        { nil }
      description { nil }
      start_date  { nil }
      end_date    { nil }
      status      { GroupEvent.statuses[:draft] }
      latitude    { nil }
      longitude   { nil }
    end
  end
end
