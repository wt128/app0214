class UsersController < ApplicationController
  def new
    @user = User.new
    #debugger
  end

  def show
    @user = User.find(params[:id])
   #debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to My App!"
      redirect_to @user #= redirect_to user_url(@user)
    else
      render 'new'
    end
  end
private #外部から見れないようにする
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
