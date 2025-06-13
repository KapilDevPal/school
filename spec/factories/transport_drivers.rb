FactoryBot.define do
  factory :transport_driver do
    school { nil }
    name { "MyString" }
    license_number { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    status { "MyString" }
    active { false }
  end
end
