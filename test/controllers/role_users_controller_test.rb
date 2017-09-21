require 'test_helper'

class RoleUsersControllerTest < ActionController::TestCase
  setup do
    @role_user = role_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:role_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create role_user" do
    assert_difference('RoleUser.count') do
      post :create, role_user: { data: @role_user.data, role_id: @role_user.role_id, user_id: @role_user.user_id }
    end

    assert_redirected_to role_user_path(assigns(:role_user))
  end

  test "should show role_user" do
    get :show, id: @role_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @role_user
    assert_response :success
  end

  test "should update role_user" do
    patch :update, id: @role_user, role_user: { data: @role_user.data, role_id: @role_user.role_id, user_id: @role_user.user_id }
    assert_redirected_to role_user_path(assigns(:role_user))
  end

  test "should destroy role_user" do
    assert_difference('RoleUser.count', -1) do
      delete :destroy, id: @role_user
    end

    assert_redirected_to role_users_path
  end
end
