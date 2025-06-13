FactoryBot.define do
  factory :transport_vehicle do
    school { nil }
    name { "MyString" }
    registration_number { "MyString" }
    vehicle_type { "MyString" }
    capacity { 1 }
    status { "MyString" }
    active { false }
  end
end
