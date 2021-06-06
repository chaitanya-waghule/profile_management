FactoryBot.define do

  factory :user do
    first_name { 'John' }
    middle_name { 'Harry' }
    last_name { 'Hawkins' }
    email { 'john@example.com' }
    password { 'password' }
  end

end
