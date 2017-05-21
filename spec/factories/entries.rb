FactoryGirl.define do
  factory :entry do
    content { Faker::Lorem.paragraph(2) }
    occurred_on { Faker::Date.between(2.days.ago, Date.today) }
    user_id nil
    linked_user_id nil

  end
end