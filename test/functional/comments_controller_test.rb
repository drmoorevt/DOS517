require 'test_helper'
require 'comments_controller'

#reraise any exception that was caught during testing
class CommentsController; def rescue_action(e) raise e end; end
class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
    @post = posts(:one)
  end

  test "should get index for admin only" do
    session[:user_id] = @user.id
    session[:user_admin] = true
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment" do
    session[:user_id] = 2

    assert_difference('Comment.count') do
      post :create,  { content: @comment.content, post_id: 1,author: "test" , user_id: 1  }
    end

    assert_redirected_to post_path(1)
  end

  test "should show comment" do
    get :show, id: @comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end

  test "should update comment" do
    put :update, id: @comment, comment: { content: @comment.content,   user_id: @comment.user_id, vote: @comment.vote }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment by admin" do

    session[:user_id] =2
    session[:user_admin] = true

    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to comments_path
  end
end
