require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  .
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('') #このテストを通すには、 記憶ダイジェストがnilの時に、falseを返す
  end
end
