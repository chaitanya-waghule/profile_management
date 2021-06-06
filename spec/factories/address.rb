FactoryBot.define do

  factory :address do
    address_line { '301 B wing' }
    city { 'Mumbai' }
    landmark { 'Statue of liberty' }
    mobile_number { 9876543210 }
    province { 'Maharashtra' }
    street { 'Baker Street' }
    user { create(:user) }
    zip { '123456' }
  end

end
