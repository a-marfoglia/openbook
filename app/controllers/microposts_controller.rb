class MicropostsController < ApplicationController
before_action :logged_in_user, only: [:new, :create]

  def index
    @microposts = Micropost.paginate(page: params[:page], per_page: 10)
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to microposts_path
    else
      render 'new'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @micropost.add_count_view
    @comment = Comment.new
  end

  private
    def micropost_params
      params.require(:micropost).permit(:title, :content, :category_id, :attachment)
    end
end
