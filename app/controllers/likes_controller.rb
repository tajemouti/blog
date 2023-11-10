class LikesController < ApplicationController
  before_action :find_post

  def create
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'You liked the post!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to like the post.'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
