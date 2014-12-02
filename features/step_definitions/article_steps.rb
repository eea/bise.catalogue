Given /^I have article titled "(.+)"$/ do |title|
  FactoryGirl.create :article, title: title, site_id: 1
  sleep(1)
end

When /^I go to the list of articles$/ do
  visit articles_path
  # save_and_open_page "articles_path_#{Time.now.strftime('')}.html"
end

When /^I search article "(.*?)"$/ do |title|
  fill_in :query, with: "#{title}\n"
  # find('#query').native.send_keys(:return)
end

Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_text text
  # page.should have_text text
end

Then /^I should see a button titled "(.*?)"$/ do |title|
  #page.should have_link title
  page.should have_text title
  #, href: send("new_#{obj}_path")
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
  fill_in 'Content'       , with: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

  click_button "Save"
end
