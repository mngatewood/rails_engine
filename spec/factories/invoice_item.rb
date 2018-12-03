FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity)   { |n| n * 10 }
    sequence(:unit_price) { |n| n * 214 }
  end
end
