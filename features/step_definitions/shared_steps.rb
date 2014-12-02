
Given /^Countries and languages are imported$/ do
  FactoryGirl.create(:site,
                     id: 1,
                     name: 'BISE',
                     origin_url: 'http://biodiversity.europa.eu')
  FactoryGirl.create(:site,
                     id: 2,
                     name: 'EUNIS',
                     origin_url: 'http://eunis.eea.europa.eu')
  Language.delete_all
  langs = [
    %w(Bulgarian BG), %w(Croatian HR), %w(Czech CS),
    %w(Danish DA), %w(Dutch NL), %w(English EN),
    %w(Estonian ET), %w(Finnish FI), %w(French FR),
    %w(German DE), %w(Greek EL), %w(Hungarian HU),
    %w(Irish GA), %w(Italian IT), %w(Latvian LV),
    %w(Lithuanian LT), %w(Maltese MT), %w(Polish PL),
    %w(Portuguese PT), %w(Romanian RO), %w(Slovak SK),
    %w(Slovenian SL), %w(Spanish ES), %w(Swedis SV)
  ]
  langs.each_with_index do |array, i|
    FactoryGirl.create(:language, id: i + 1, name: array[0], code: array[1])
  end
end



