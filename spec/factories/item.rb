FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "Item #{n}" }
    sequence(:unit_price)       { |n| 2.14 * n }
  end
end
