require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
    def setup
        @user = users(:Michale)
        remember(@user)
    end

    test "current_user returns right user when session is nil" do
        assert_equal @user, current_user #expected , actual
        assert is_logged_in?
    end

    test "current_user returns nil when remeber digest is wrong" do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        assert_nil current_user
    end

    #記憶しurlにリダイレクトする
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end
    #アクセスしようとしたurlを覚えておく
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
    
end