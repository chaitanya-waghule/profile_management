FactoryBot.define do

  factory :admin_user do
    first_name { 'John' }
    middle_name { 'Harry' }
    last_name { 'Hawkins' }
    email { 'admin_john@example.com' }
    password { 'password' }
  end

end
