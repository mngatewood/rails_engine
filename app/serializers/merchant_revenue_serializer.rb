class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer  
  attribute :revenue do |object|
    (object.revenue.round(2)/100).to_s
  end
end
