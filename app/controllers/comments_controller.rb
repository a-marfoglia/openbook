class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :delete]

  def create
    @comment = Comment.new(comment_params, user_id: current_user.id)
    if @comment.save
      flash[:success] = "Il commento è stato pubblicato con successo"
    else
      flash[:danger] = "Il contenuto del commento non può essere vuoto, ne superare i 150 caratteri di lunghezza."
    end
    redirect_to micropost_path(params[:comment][:micropost_id]) || microposts_path
  end

  def delete
  end

  private
    def comment_params
      params_hash = params.require(:comment).permit(:content, :micropost_id)
      params_hash[:user_id] = current_user.id
      params_hash
    end
end
