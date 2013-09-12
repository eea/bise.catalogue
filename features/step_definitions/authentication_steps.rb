Given /^I am authenticated with ldap$/ do
  create :user, login: "arriejon"

  visit '/users/sign_in'
  fill_in "Login",    with: "arriejon"
  fill_in "Password", with: "password"
  click_button "Sign in"
end