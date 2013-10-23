# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :species_translation, :class => 'SpeciesTranslation' do
    locale "es"
    name "Lobo"
    # species nil
  end
end
