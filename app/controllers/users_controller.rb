class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,  only: :destroy
  def new
    @user = User.new
    #debugger
  end

  def show
    @user = User.find(params[:id])
   #debugger
  end

  def index
    @user = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #登録したあと、ログイン。
      flash[:success] = "Welcome to My App!"
      redirect_to @user #= redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit 
    @user = User.find(params[:id])
    end
private #外部から見れないようにする
  def user_params
    params.require(:user).permit(:password,:password_confirmation)
  end



  def update
    @user = User.find(params[:id])
    if @user.attributes(user_params)
      #登録に成功した場合を扱う
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

    private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end #strong parameterによるマスアサイメント処理


    # beforeアクション
    #　ログイン済みユーザーかcheckc
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user 
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end

    private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
