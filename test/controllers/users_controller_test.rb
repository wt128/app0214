require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Michale)
    @user_other = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "login with valid inf." do
    get login_path
    post login_path, params: {session: {user:@user.name,
                                        password:"passwd"}}
    assert is_logged_in?
    assert redirect_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,   count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {user: { name: @user.name,
    email: @user.email  }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in " do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
      end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@user_other)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  

end
