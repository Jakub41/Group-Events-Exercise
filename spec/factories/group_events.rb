FactoryBot.define do
  factory :group_event do
    name { "MyString" }
    description { "MyText" }
    start_date { "2018-12-16" }
    end_date { "2018-12-16" }
    duration { 1 }
    status { 1 }
    latitude { "9.99" }
    longitude { "9.99" }
    deleted_at { "2018-12-16 22:42:58" }
  end
end
