class PostsController < ApplicationController
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

  def like
    @post = Post.find(params[:id])
    @post.increment!(:likes_count)
  
    respond_to do |format|
      format.js
    end
  end
  
  def dislike
    @post = Post.find(params[:id])
    @post.decrement!(:likes_count)
  
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'You can only delete your own posts.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end