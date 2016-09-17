class PictureUploadsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(picture: params[:user][:picture])
      redirect_to @user
    else
      flash[:danger] = "Sono supportate solamente immagini nei formati *.jpeg, *jpg, *.png, *.gif e inferiori a un peso di 5MB."
      redirect_to @user
    end
  end
end
