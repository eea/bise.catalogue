Given /^I am authenticated with ldap$/ do
  create :user, login: "arriejon"

  visit '/users/sign_in'
  fill_in "Login",    with: ENV['EIONET_USER']
  fill_in "Password", with: ENV['EIONET_PASS']
  click_button "Sign in"
end