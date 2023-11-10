class CommentsController < ApplicationController
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

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
