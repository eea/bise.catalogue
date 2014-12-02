# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login 'demouser'
    password 'demopass'
    sign_in_count 0
    current_sign_in_at 2.days.from_now.to_f
    last_sign_in_at 2.months.from_now.to_f
    current_sign_in_ip "127.0.0.1"
    last_sign_in_ip "127.0.0.1"
    created_at 2.years.from_now.to_f
    updated_at 2.years.from_now.to_f
    role_admin false
    role_validator false
    role_author true
  end
end
