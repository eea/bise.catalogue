require 'factory_girl'

# ----- Create default sites
Site.delete_all
FactoryGirl.create(:site,
                   name: 'BISE',
                   origin_url: 'http://biodiversity.europa.eu')
FactoryGirl.create(:site,
                   name: 'EUNIS',
                   origin_url: 'http://eunis.eea.europa.eu')

# ----- Create default languages
Language.delete_all
langs = [
  %w(Bulgarian BG),
  %w(Croatian HR),
  %w(Czech CS),
  %w(Danish DA),
  %w(Dutch NL),
  %w(English EN),
  %w(Estonian ET),
  %w(Finnish FI),
  %w(French FR),
  %w(German DE),
  %w(Greek EL),
  %w(Hungarian HU),
  %w(Irish GA),
  %w(Italian IT),
  %w(Latvian LV),
  %w(Lithuanian LT),
  %w(Maltese MT),
  %w(Polish PL),
  %w(Portuguese PT),
  %w(Romanian RO),
  %w(Slovak SK),
  %w(Slovenian SL),
  %w(Spanish ES),
  %w(Swedis SV)
]
langs.each_with_index do |array, i|
  FactoryGirl.create(:language, id: i + 1, name: array[0], code: array[1])
end

