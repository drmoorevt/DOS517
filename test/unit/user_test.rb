require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "if mandatory attributes are present" do
    user = User.new
    assert user.invalid?
    assert user.errors[:username].any?, "user name cannot be empty"
    assert user.errors[:email].any?, "email cannot be empty"
    assert user.errors[:password].any?, "password cannot be empty"
    assert user.errors[:first_name].any?, "first_name cannot be empty"
    assert user.errors[:last_name].any?, "last_name cannot be empty"
  end
  test "email format is wrong" do
    mypasswd = "h*&JKJ()"
    user = User.new(
        :username => "abc123",
        :email => "testuser@@@",
        :first_name => "abc",
        :last_name => "xat",
        :password => mypasswd,
        :password_confirmation =>mypasswd)
    user.save
    assert user.invalid?

    assert user.errors[:email].any?, "email cannot be empty"

  end
  test "if password matches correctly" do
    mypasswd = "h*&JKJ()"
    user = User.new(
        :username => "abc123",
        :email => "testuser@abc.com",
        :first_name => "abc",
        :last_name => "xat",
        :password => mypasswd)
    user.save
    assert user.has_same_password(mypasswd) == true, "password did not match"
    assert user.has_same_password("mypasswd") == false, "password match"
  end

  test "to validate names and password needn't be unique" do
    mypasswd = "JKO*(&*("
    firstname = "Sam"
    lastname = "jim"
    username1, username2 = "abc1", "abc2"
    email1, email2 = "abc1@rad.com", "abc2@rad.com"
    user1 = User.new(
        :username => username1,
        :email => email1,
        :first_name => firstname,
        :last_name => lastname,
        :password => mypasswd)
    user1.save

    user2 = User.new(
        :username => username2,
        :email => email2,
        :first_name => firstname,
        :last_name => lastname,
        :password => mypasswd)

    assert user2.valid?, "failed to create a valid user with same first_name, last_name and password"
  end

  test "to authenticate an existing user" do
    mypasswd1, mypasswd2 = "N*(&*HJK","M)U*UL"
    username1, username2 = "abc1", "abc2"
    email1, email2 = "abc1@rad.com", "abc2@rad.com"
    first_name = "alex"
    last_name = "ron"

    user1 = User.new(
        :username => username1,
        :email => email1,
        :first_name => "abc1",
        :last_name => "xat1",
        :password => mypasswd1)
    user1.save

    assert_equal user1, User.authenticate(username1,mypasswd1), "failed to authenticate valid username"
    assert_equal user1, User.authenticate(email1,mypasswd1), "failed to authenticate valid email"
    assert User.authenticate(email1,mypasswd2) == false, "failed to authenticate an invalid password"
    assert User.authenticate(username2,mypasswd2) == false, "failed to authenticate an invalid username"
    assert User.authenticate(email2,mypasswd2) == false, "failed to authenticate an invalid email"

    user2 = User.new(
        :username => username2,
        :email => email2,
        :first_name => "abc1",
        :last_name => "xat1",
        :password => mypasswd2)
    user2.save

    assert_equal user2, User.authenticate(username2,mypasswd2), "failed to authenticate a valid new username"
    assert_not_equal user1, User.authenticate(username2,mypasswd2), "failed to authenticate incorrect user accounts by usernane"
    assert_not_equal user1, User.authenticate(email2,mypasswd2), "failed to authenticate incorrect user accounts by email"
  end

  test "to validate duplicate users" do
    mypasswd = "N*(&*HJK"
    username1, username2, username3 = "abc1", "abc2", "abc3"
    email1, email2, email3 = "abc1@rad.com", "abc2@rad.com", "abc3@rad.com"

    user1 = User.new(
        :username => username1,
        :email => email1,
        :first_name => "abc1",
        :last_name => "xat1",
        :password => mypasswd)

    assert user1.valid?, "failed to create a valid user"
    user1.save

    user2 = User.new(
        :username => username1,
        :email => email2,
        :first_name => "abc1",
        :last_name => "xat1",
        :password => mypasswd)

    assert user2.invalid?, "failed to validate duplicate username"
    user2.username = username2
    assert user2.valid?, "failed to create a user with unique username"
    user2.save

    user3 = User.new(
        :username => username3,
        :email => email2,
        :first_name => "abc1",
        :last_name => "xat1",
        :password => mypasswd)

    assert user3.invalid?, "failed to validate duplicate email"
    user3.email = email3
    assert user3.valid?, "failed to create a user with unique email"
    user3.save
  end

end
