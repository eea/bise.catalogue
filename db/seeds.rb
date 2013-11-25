require 'factory_girl'

# Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}


# ----- Creating default sites
Site.delete_all
FactoryGirl.create(:site, name: 'BISE', origin_url: 'http://biodiversity.europa.eu')
FactoryGirl.create(:site, name: 'EUNIS', origin_url: 'http://eunis.eea.europa.eu')

# ----- Creating default languages
Language.delete_all
langs = [
  'Bulgarian', 'Croatian', 'Czech', 'Danish', 'Dutch', 'English', 'Estonian',
  'Finnish', 'French', 'German', 'Greek', 'Hungarian', 'Irish', 'Italian',
  'Latvian', 'Lithuanian', 'Maltese', 'Polish', 'Portuguese', 'Romanian',
  'Slovak', 'Slovenian', 'Spanish', 'Swedis'
].each_with_index do |lang, i|
  FactoryGirl.create(:language, id: i+1, name: lang)
end
