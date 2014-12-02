Given /^I am authenticated with ldap$/ do
  visit '/users/sign_in'
  fill_in "Login",    with: ENV['EIONET_USER']
  fill_in "Password", with: ENV['EIONET_PASS']
  click_button "Sign in"
end

Given(/^I'm allowed in "(.*?)" library$/) do |library|
  Dotenv.load(Rails.root.join('Dotenv.env'))
  site = Site.find_by_name(library)
  user = User.find_by_login(ENV['EIONET_USER'])
  user.library_roles.push LibraryRole.new(user_id: user.id, site_id: site.id, allowed: true)
  binding.pry
end