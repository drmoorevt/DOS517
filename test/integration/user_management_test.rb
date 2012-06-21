require 'test_helper'

class UserManagementTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "Register user and login" do
    visit(auth_login_path)
    click_link("register")
    fill_in("Username", :with => "satcat")
    fill_in("Email", :with => "satcat@abc.com")
    fill_in("First name", :with => "sat")
    fill_in("Last name", :with => "cat")
    fill_in("Password", :with => "sat123")
    fill_in("Password confirmation", :with => "sat123")
    click_button("Create User")
    visit(auth_login_path)
    fill_in("username_or_email", :with => "satcat")
    fill_in("password", :with => "sat123")
    click_button("Log In")
  end

  test "Delete a registered user" do
    visit(auth_login_path)
    click_link("register")
    fill_in("Username", :with => "satcat")
    fill_in("Email", :with => "satcat@abc.com")
    fill_in("First name", :with => "sat")
    fill_in("Last name", :with => "cat")
    fill_in("Password", :with => "sat123")
    fill_in("Password confirmation", :with => "sat123")
    click_button("Create User")
    visit(auth_login_path)
    fill_in("username_or_email", :with => "admin")
    fill_in("password", :with => "admin")
    click_button("Log In")
    visit(posts_path)
    click_link("Destroy")


  end

end
