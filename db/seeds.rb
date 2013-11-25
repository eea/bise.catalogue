require 'factory_girl'

# Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}


# ----- Creating default sites
Site.delete_all
FactoryGirl.create(:site, name: 'BISE', origin_url: 'http://biodiversity.europa.eu')
FactoryGirl.create(:site, name: 'EUNIS', origin_url: 'http://eunis.eea.europa.eu')

# ----- Creating default languages
Language.delete_all
langs = [
  ['Bulgarian'  , 'BG'],
  ['Croatian'   , 'HR'],
  ['Czech'      , 'CS'],
  ['Danish'     , 'DA'],
  ['Dutch'      , 'NL'],
  ['English'    , 'EN'],
  ['Estonian'   , 'ET'],
  ['Finnish'    , 'FI'],
  ['French'     , 'FR'],
  ['German'     , 'DE'],
  ['Greek'      , 'EL'],
  ['Hungarian'  , 'HU'],
  ['Irish'      , 'GA'],
  ['Italian'    , 'IT'],
  ['Latvian'    , 'LV'],
  ['Lithuanian' , 'LT'],
  ['Maltese'    , 'MT'],
  ['Polish'     , 'PL'],
  ['Portuguese' , 'PT'],
  ['Romanian'   , 'RO'],
  ['Slovak'     , 'SK'],
  ['Slovenian'  , 'SL'],
  ['Spanish'    , 'ES'],
  ['Swedis'     , 'SV']
]
langs.each_with_index do |array, i|
  FactoryGirl.create(:language, id: i+1, name: array[0], code: array[1])
end
