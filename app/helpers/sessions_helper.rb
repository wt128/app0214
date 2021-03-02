module SessionsHelper
   def log_in(user)
        #渡されたユーザーでログインする
        session[:user_id] = user.id
    end

    def remember(user)
        user.remeber
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remeber_token] = user.remeber_token
    end

    #渡されたユーザーがログイン済みユーザーであれば、trueを返却
    def current_user?(user)
        user == current_user
    end
    
    def current_user #記憶トークンcookieに対応するユーザーをかえす
        if session[:user_id]
            @current_user ||= User.find_by(id: :user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remeber_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def log_out #ログアウト
        session.delete(:user_id)
        @current_user = nil
    end

    #永続セッションからログアウト
    #渡されたユーザーでログイン
    def log_in(user)
        session[:user_id] = user.id
    end
    #永続セッションの破棄
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remeber_token)
    end
    #現在のユーザーをログアウト
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
        
end
