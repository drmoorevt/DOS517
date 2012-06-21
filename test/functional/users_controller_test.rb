require 'test_helper'
require 'users_controller'

#reraise any exception that was caught during testing
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase
  setup do
    @controller = UsersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @user = users(:one)
  end

  test "should get index for admin only" do
    @user = users(:two)
    session[:user_id] = @user.id
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
   p @user
    assert_difference('User.count') do
      post :create, user: { admin_flag: @user.admin_flag, description: @user.description, email: 'anotheremail@gmail.com', first_name: @user.first_name, last_name: @user.last_name, password: @user.password,password_confirmation: @user.password, username: 'somethingelse' }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should fail to create user for email format" do
    p @user

      post :create, user: { admin_flag: @user.admin_flag, description: @user.description, email: 'anotheremail@', first_name: @user.first_name, last_name: @user.last_name, password: @user.password,password_confirmation: @user.password, username: 'somethingelse' }
    assert_template 'new'
  end


  test "should redirect user for show action if not logged" do
    get :show, id: @user.id
    assert_response :redirect
    assert_redirected_to :action => "login" ,:controller => "auth"
    assert_equal 'Please log in to access this page', flash[:notice]
  end

  test "should get edit page for loginstatus" do
    #fix login
    session[:user_id] = @user.id
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    #fix login
    session[:user_id] = @user.id
    put :update, id: @user, user: { admin_flag: @user.admin_flag, description: @user.description, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password, username: @user.username }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user for admin" do
    @user = users(:two)
    session[:user_id] = @user.id
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
