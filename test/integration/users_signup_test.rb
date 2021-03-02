require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 test "invalid signup information" do
  get signup_path
  assert_no_difference 'User.count' do
    post users_path, params: {
        user: {
          name: " ",
          email: "vfvsdf@email.com",
          password: "foo",
          password_confirmation:"boo"
        }
    } 
    assert_template 'users/new'
    assert_select 'div.alert.alert-danger','The form contains 3 errors'
   
  end
end

  test "valid signup state" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {              
        user: {
          name: "tatito",
          email: "ttttt@email.com",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
      follow_redirect!
      assert_template 'users/show'
      assert is_logged_in?
end



end
