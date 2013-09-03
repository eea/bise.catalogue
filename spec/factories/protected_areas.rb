# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :protected_area do
    code 1
    uri "MyString"
    name "MyString"
    designation_year 1
    nuts_code "MyString"
    area ""
    length ""
    long ""
    lat ""
    source_db "MyString"
  end
end
