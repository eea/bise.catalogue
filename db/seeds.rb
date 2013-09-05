
# contents = [
# 'Lorem ipsum dolor sit amet.',
# 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt.',
# 'Labore et dolore magna aliqua.',
# 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
# 'Excepteur sint occaecat cupidatat non proident.'
# ]

# puts "Deleting all articles..."
# Article.delete_all

# unless ENV['COUNT']

#   puts "Creating articles..."
#   %w[ One Two Three Four Five ].each_with_index do |title, i|
#     Article.create :title => title, :content => contents[i], :published_on => i.days.ago.utc
#   end

# else

#   puts "Creating 10,000 articles..."
#   (1..ENV['COUNT'].to_i).each_with_index do |title, i|
#     Article.create :title => "Title #{title}", :content => 'Lorem', :published_on => i.days.ago.utc
#     print '.'
#   end

# end


# ----- Creating default sites
Site.delete_all

bise = Site.new
bise.id = 1
bise.name = 'BISE'
bise.origin_url = 'http://biodiversity.europa.eu'
bise.save

eunis = Site.new
eunis.id = 2
eunis.name = 'EUNIS'
eunis.origin_url = 'http://eunis.eea.europa.eu'
eunis.save

# ----- Creating default languages
Language.delete_all
langs = [
  'Bulgarian',
  'Croatian',
  'Czech',
  'Danish',
  'Dutch',
  'English',
  'Estonian',
  'Finnish',
  'French',
  'German',
  'Greek',
  'Hungarian',
  'Irish',
  'Italian',
  'Latvian',
  'Lithuanian',
  'Maltese',
  'Polish',
  'Portuguese',
  'Romanian',
  'Slovak',
  'Slovenian',
  'Spanish',
  'Swedis'
]

langs.each_with_index do |l,i|
  language = Language.new
  language.id = i + 1
  language.name = l
  language.save
end
