require 'test_helper'
require 'posts_controller'

#reraise any exception that was caught during testing
class PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < ActionController::TestCase
  setup do
    @controller = PostsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @user = users(:one)
    @post = posts(:one)
  end

  test "should get index for authorized user" do
    session[:user_id] = @user.id
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new post for authorized user" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test "should not get new post for guest user" do

    get :new
    assert_response :redirect
    assert_equal 'Please log in to access this page', flash[:notice]
  end

  test "should create post for authorized user" do
    session[:user_id] = @user.id
    assert_difference('Post.count') do
      post :create, post: { content: @post.content, title: @post.title, user_id: @user.id }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post for all" do
    get :show, id: @post.id
    assert_response :success
  end

  test "should get edit  post if belongs to user" do
    session[:user_id] =@post.user_id
    get :edit, id: @post.id
    assert_response :success
  end

  test "should update post if belongs to user" do
    session[:user_id] = @post.user_id
    put :update, id: @post.id, post: { content: @post.content, title: @post.title, user_id: @post.user_id }
    assert_redirected_to post_path(assigns(:post))
  end

  #we have two users with ids 1 and 2 post belongs to userid 1
  test "should not update post for others" do
    session[:user_id] =2
    put :update, id: @post.id, post: { content: @post.content, title: @post.title  }
    assert_redirected_to :action => "unauthorized"

  end

  test "should destroy post if belongs to user" do
    session[:user_id] =@post.user_id
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.id
    end

    assert_redirected_to posts_path
  end

  test "should not destroy post if it does not belong to user" do
    session[:user_id] =234234
      delete :destroy, id: @post
    assert_redirected_to :action => "login" ,:controller => "auth"
    assert_equal 'Please log in to access this page', flash[:notice]
  end
end
