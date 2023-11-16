class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params.merge(post: @post))

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @user = @post.author
    @comment.destroy
    @post.comments_counter -= 1

    redirect_to user_post_path(@user, @post) if @post.save
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
