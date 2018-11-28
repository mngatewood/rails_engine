require 'rails_helper'

describe Invoice, type: :model do
    describe 'Validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
  end

  describe 'Relationship' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :items }
  end

  describe 'Methods' do
  end

end