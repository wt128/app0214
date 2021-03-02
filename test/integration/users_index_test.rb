require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Michale)
  end

  test "index including pagination" do
    log_in_as(@user)
    get user_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
    end
  end

  test "index as non-admin" do
    log_in_as(@non-admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
