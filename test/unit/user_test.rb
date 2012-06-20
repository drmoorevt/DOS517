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
  end

  test "if password matches correctly" do
    mypasswd = "h*&JKJ()"
    user = User.new(
        :username => "abc123",
        :email => "testuser@abc.com",
        :password => mypasswd)
    user.save
    assert user.has_same_password(mypasswd) == true, "password did not match"
    assert user.has_same_password("mypasswd") == false, "password match"
  end

  test "to validate existing user" do
    mypasswd1, mypasswd2 = "N*(&*HJK","M)U*UL"
    username1, username2 = "abc1", "abc2"
    email1, email2 = "abc1@rad.com", "abc2@rad.com"

    user1 = User.new(
        :username => username1,
        :email => email1,
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
        :password => mypasswd)

    assert user1.valid?, "failed to create a valid user"
    user1.save

    user2 = User.new(
        :username => username1,
        :email => email2,
        :password => mypasswd)

    assert user2.invalid?, "failed to validate duplicate username"
    user2.username = username2
    assert user2.valid?, "failed to create a user with unique username"
    user2.save

    user3 = User.new(
        :username => username3,
        :email => email2,
        :password => mypasswd)

    assert user3.invalid?, "failed to validate duplicate email"
    user3.email = email3
    assert user3.valid?, "failed to create a user with unique email"
    user3.save
  end

end
