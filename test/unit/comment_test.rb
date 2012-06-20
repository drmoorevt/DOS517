require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "if Comments honors optional and mandatory attributes correctly" do
    comment = Comment.new
    assert comment.invalid?
    assert comment.errors[:author].any?, "the comment author cannot be empty"
    assert comment.errors[:post_id].any?, "the Comment post_id cannot be empty"
    assert !comment.errors[:user_id].any?, "the comment user_id can be empty to support guest user"
    assert !comment.errors[:content].any?, "the comment may be nil for voting"
  end
end