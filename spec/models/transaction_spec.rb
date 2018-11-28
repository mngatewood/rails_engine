require 'rails_helper'

describe Transaction, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :credit_card_expiration }
    it { should validate_presence_of :result }
    it { should validate_presence_of :invoice_id }
  end

  describe 'Relationship' do
    it { should belong_to :invoice }
  end

  describe 'Methods' do
  end

end
