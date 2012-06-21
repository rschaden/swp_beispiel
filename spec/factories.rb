FactoryGirl.define do
  factory :user do
    name    "Rainer S"
    email   "rainer@example.com"
    password    "foobar"
    password_confirmation   "foobar"
  end
end