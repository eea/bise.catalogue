Given /^I have article titled (.+)$/ do |title|
  FactoryGirl.create :article, title: title
  # titles.split(', ').each do |title|
  #   # Article.create!(:title => title)
  #   FactoryGirl.create :article, title: title
  # end
end

When /^I go to the list of articles$/ do
  visit articles_path
end

When /^I search article "(.*?)"$/ do |title|
  fill_in :query, with: "#{title}\n"
  # find('#query').native.send_keys(:return)
end

Then /^I should see "(.*?)"$/ do |text|
  uri = Rails.root.join("tmp/capybara/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.png")
  page.driver.render uri, full: true
  # Capybara.save_page Rails.root.join("tmp/capybara/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.html")
  # page.driver.render Rails.root.join("tmp/capybara/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.png")
  # page.save_screenshot 'screenshot.png'
  # Launchy.open 'screenshot.png' # or open manually
  page.should have_text text
end

Then /^I should see new (.*?) button titled "(.*?)"$/ do |obj, title|
  page.should have_link title, href: send("new_#{obj}_path")
end

Then /^I can register a new article$/ do
  click_link "New Article"

  fill_in 'Title'         , with: 'Articulo de ejemplo sobre biodiversidad'
  fill_in 'English title' , with: 'Example article about Biodiversity'
  select 'Spanish'        , from: 'article_language_ids'
  select 'English'        , from: 'article_language_ids'
  select 'BISE'           , from: 'article_site_id'
  fill_in 'Published on'  , with: '01/01/2013'
  fill_in 'Author'        , with: 'Jon Arrien'

  click_button "Save"
end