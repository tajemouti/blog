class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(posts: :author).find(params[:id])
  end
end
