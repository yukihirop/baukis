FactoryGirl.define do
  factory :administrator do
    sequence(:email){ |n| "admin#{n}@example.com" }
    password 'admin'
    suspended false
  end
end
