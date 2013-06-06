
contents = [
'Lorem ipsum dolor sit amet.',
'Consectetur adipisicing elit, sed do eiusmod tempor incididunt.',
'Labore et dolore magna aliqua.',
'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
'Excepteur sint occaecat cupidatat non proident.'
]

puts "Deleting all articles..."
Article.delete_all

unless ENV['COUNT']

  puts "Creating articles..."
  %w[ One Two Three Four Five ].each_with_index do |title, i|
    Article.create :title => title, :content => contents[i], :published_on => i.days.ago.utc
  end

else

  puts "Creating 10,000 articles..."
  (1..ENV['COUNT'].to_i).each_with_index do |title, i|
    Article.create :title => "Title #{title}", :content => 'Lorem', :published_on => i.days.ago.utc
    print '.'
  end

end
