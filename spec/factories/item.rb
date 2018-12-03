FactoryBot.define do
  factory :item do
    sequence(:name)             { |n| "Item #{n}" }
    sequence(:description)      { |n| "Item #{n}" }
    sequence(:unit_price)       { |n| 214 * n }
  end
end
