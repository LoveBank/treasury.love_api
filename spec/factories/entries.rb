FactoryGirl.define do
  factory :entry do
    content { Faker::Lorem.paragraph(2) }
    occurred_on { Faker::Date.between(2.days.ago, Date.today) }
    profile_id nil
  end
end