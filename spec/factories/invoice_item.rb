FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity)   { |n| n * 10 }
    sequence(:unit_price) { |n| n * 2.14 }
  end
end
