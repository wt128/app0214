class User < ApplicationRecord
    attr_accessor :remeber_token
    before_save { email.downcase! }
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence:true, length: {maximum: 255}, 
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: {minimum: 6}

    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token #ランダムなトークン
        SecureRandom.urlsafe_base64
    end

    def remember #永続セッションのためにユーザーをdbに記憶
        self.remember_token = User.new_token
        update_attribute(:remember_digest)
    end

    def authenticated?(remember_token) #渡されたトークンがダイジェストと一致したらtrue
        if remember_digest.nil?
            false
        else
            BCrypt::Password.new(remember_digest).is_password?(remeber_token)
            end
        end

    def forget #ユーザーのログイン情報を破棄
        update_attribute(:remember_digest, nil) 
    end

    
end
