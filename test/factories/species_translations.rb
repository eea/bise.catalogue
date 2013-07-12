# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :species_translation, :class => 'SpeciesTranslations' do
    locale "MyString"
    name "MyString"
    species nil
  end
end
