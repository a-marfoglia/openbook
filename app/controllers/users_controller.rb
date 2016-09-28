class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Benvenuto su Openbook!"
      redirect_to @user
    else
      flash[:trigger_modal] = "signup"
      flash[:signup_errors] = @user.errors.full_messages
      redirect_to forwarding_url || root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if password_change? && @user.authenticate(params[:user][:password])
      # Try to change pw
      if match_password?
        if @user.update_attributes(password: params[:user][:new_password])
          flash[:success] = "Password cambiata con successo."
          redirect_to @user
        else
          flash.now[:danger] = "La password... format"
          render 'edit'
        end
      else
        flash.now[:danger] = "Le due password non combaciano."
        render 'edit'
      end
    elsif !edit_user_params.empty? && @user.update_attributes(edit_user_params)
      # Just update attributes
      flash[:success] = "Modifica effettuata."
      redirect_to @user
    else
      # If it fails render edit and show errors
      flash.now[:danger] = "Password inserita errata."
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def edit_user_params
      params.require(:user).permit(:name, :occupation, :birth_date)
    end

    def forwarding_url
      params[:user][:forwarding_url]
    end

    def password_change?
      defined? params[:user][:password]
    end

    def match_password?
      params[:user][:new_password] == params[:user][:new_password_confirmation]
    end
end
