class PictureUploadsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(picture: params[:user][:picture])
      redirect_to @user
    else
      flash.now[:danger] = @user.errors.full_messages
      render 'edit'
    end
  end
end
