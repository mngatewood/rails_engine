FactoryBot.define do
  factory :transaction do
    credit_card_number { '9999999999999999' }
    credit_card_expiration { '9999' }
    result { 'success' }
  end
end