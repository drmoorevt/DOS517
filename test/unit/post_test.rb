require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "if Post honors optional and mandatory attributes correctly" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:content].any?, "the post description cannot be empty"
    assert post.errors[:title].any?, "the post title cannot be empty"
    assert post.errors[:user_id].any?, "the post requires a username"
    assert !post.errors[:vote].any?, "the post may not have a vote"
  end

  test "all the length constraints for posts" do
    content = "c" * 141
    title = "t" * 50
    username = "abc"

    post = Post.new(
        :content => content,
        :title => title,
        :user_id => "abc")

    assert post.invalid?, "the max length for description cannot be more than  140"
    post.content = nil
    assert post.invalid?, "the length of description must be greater than zero"
    post.content = " " * 140
    assert post.invalid?, "the description cannot be blank"
    post.content = "c" * 140
    assert post.valid?, "the max length for description can be 140"
    post.title = "t" * 51
    assert post.invalid?, "the max length for title cannot be more than 50"
    post.title = nil
    assert post.invalid?, "the length of title must be greater than zero"
    post.title = " " * 50
    assert post.invalid?, "the title cannot be blank"
    post.title = "t" * 50
    assert post.valid?, "the max length for title can be 50"

  end

  test "if user can post duplicate posts and comments" do
    content = "my content " * 5
    title = "my title" * 2
    username = "abc"

    post1 = Post.new(
        :content => content,
        :title => title,
        :user_id => "abc")
    post1.save

    post2 = Post.new(
        :content => content,
        :title => title,
        :user_id => "abc")
    post2.save
    assert post2.valid?, "user can post duplicate posts and comments"
  end

  test "the search operations" do
    content1, content2, content3= "abc", "def"
    title1, title2, title3= "123", "456"
    username1, username2, username3 = "x1", "x2"

    post1 = Post.new(
        :content => content1,
        :title => title1,
        :user_id => username1)
    post1.save
    puts "****"
    #puts Post.search content1
    puts "****"
  end

end
