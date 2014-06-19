# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unprocessed_object do
    model "MyString"
    http_method "MyString"
    field "MyString"
    message "MyString"
    ip "MyString"
    params "MyText"
  end
end
