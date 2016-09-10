class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:trigger_modal] = 'login'
        flash[:login_error] = "Area riservata, effettua prima il login"
        redirect_to root_path
      end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
