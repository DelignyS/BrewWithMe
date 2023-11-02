class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create, :index]
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  def index
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = 'Post was successfully deleted.'
    else
      flash[:alert] = 'You can only delete your own posts.'
    end
    redirect_to posts_path
  end
  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
