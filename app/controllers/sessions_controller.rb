class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to forwarding_url || root_path
    else
      flash[:trigger_modal] = "login"
      flash[:login_error] = 'Combinazione email/password non valida'
      redirect_to forwarding_url || root_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def forwarding_url
      params[:session][:forwarding_url]
    end
end
