FactoryGirl.define do
  factory :user do
    name    "rainers"
    email   "rain@example.com"
    password    "foobar"
    password_confirmation   "foobar"
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end