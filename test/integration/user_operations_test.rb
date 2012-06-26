require 'test_helper'

class UserOperationsTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    create_user "user1","pass","fname","lname","fn@ln.com"
  end


  test "User registration is functioning" do
    visit(auth_login_path)
    click_link("register")
    fill_in("Username", :with => "cat")
    fill_in("Email", :with => "cat@abc.com")
    fill_in("First name", :with => "cat")
    fill_in("Last name", :with => "rat")
    fill_in("Password", :with => "cat123")
    fill_in("Password confirmation", :with => "cat123")
    click_button("Create User")
  end

  test "User is able to login and logout" do
    visit(auth_login_path)
    fill_in("username_or_email", :with => "user1")
    fill_in("password", :with => "pass")
    click_button("Log In")
    click_link("LogOut")
  end


  test "Users can post" do
    login "user1", "pass"
    click_link("New Post")
    fill_in("Title", :with => "my title")
    fill_in("Content", :with => "my content")
    click_button("Create Post")
    click_link("LogOut")
  end

  test "Users can search post" do
    login "user1", "pass"
    click_link("New Post")
    fill_in("Title", :with => "search-t")
    fill_in("Content", :with => "search-c")
    click_button("Create Post")
    click_link("Posts")
    fill_in("search_str", :with => "search-t")
    click_button("Search")
    click_link("LogOut")
  end

  test "Users can add comment to post" do
    create_user "user2","pass","fname","lname","fn2@ln.com"
    login "user2", "pass"
    click_link("New Post")
    fill_in("Title", :with => "user2post")
    fill_in("Content", :with => "user2content")
    click_button("Create Post")
    click_link("LogOut")
    login "user1", "pass"
    click_link("Show")
    fill_in("content", :with => "this is a comment by user1")
    click_button("Save")
    click_link("LogOut")
  end

  test "Users can edit own profile" do
    login "user1", "pass"
    click_link("Profile")
    click_link("Edit")
    fill_in("user_first_name", :with => "ufname")
    fill_in("user_last_name", :with => "ulname")
    click_button("Update User")
    click_link("LogOut")
  end

  def login (name, pass)
    visit(auth_login_path)
    fill_in("username_or_email", :with => name)
    fill_in("password", :with => pass)
    click_button("Log In")
  end

  def create_user (name, pass, fname, lname, email)
    visit(auth_login_path)
    click_link("register")
    fill_in("Username", :with => name)
    fill_in("Email", :with => email)
    fill_in("First name", :with => fname)
    fill_in("Last name", :with => lname)
    fill_in("Password", :with => pass)
    fill_in("Password confirmation", :with => pass)
    click_button("Create User")
  end

end
