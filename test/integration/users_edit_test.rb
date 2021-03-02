require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:Michale)
    end

    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'

        patch user_path(@user), params: { user: {name: "",
                                                email:"foo@valid.com",
                                                password:"000000",
                                                password_confirmation:"0000j0"}}
        
        assert_template 'users/edit'
    end

    test "successful test" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        name = "foooo"
        email = "foo@bar.com"
        patch user_path(@user), params: {user: {
        name:  name,
        email: email,
        password:              "",
        password_confirmation: "" } }
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal name, @user.name
        assert_equal email, @user.email
    end

    test "successful edit with friendly forwarding" do
        get edit_user_path(@user)
        log_in_as(@user)
        assert_redirected_to edit_user_url(@user)
        name = "fooo"
        email = "refer@u-aizu.ac.jp"
        patch user_path(@user), params: { user: { name:  name,
        email: email,
        password:              "",
        password_confirmation: "" } }

        assert_not flash.empty?
        assert_redirected_to @user
        assert_equal name, @user.name
        assert_equal email, @user.email
    end
    
end
