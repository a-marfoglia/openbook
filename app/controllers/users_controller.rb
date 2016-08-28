class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Benvenuto su Openbook!"
      redirect_to @user
    else
      flash[:trigger_modal] = "signup"
      flash[:errors] = @user.errors.full_messages
      redirect_to forwarding_url || root_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def forwarding_url
      params[:user][:forwarding_url]
    end
end
