
Given /^I have articles titled (.+)$/ do |titles|
    titles.split(', ').each do |title|
        Article.create!(:title => title)
    end
end
