class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :find_post, only: [:show]
  before_action :initialize_like

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 6)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    @post.destroy
    @user.posts_counter -= 1

    redirect_to user_posts_path(@user) if @user.save
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def initialize_like
    @like = Like.new
  end
end
