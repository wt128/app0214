require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest

  def setup #this execute the method before testing "setup"
    @base_title = "Ruby on Rails"
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should get home" do
    get home_path
    assert_response :success
    assert_select "title","#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title","Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title","About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title","Contact | #{@base_title}"
  end
    

end
