class Api::CommentsController < ApiController
  def index
    @post = Post.find(params[:post_id])
    render json: @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(text: params[:comment][:text], user: current_user)

    if comment.save
      render json: { success: 'Comment created successfully' }
    else
      render json: { error: 'Failed to create comment', details: comment.errors.full_messages },
             status: :unprocessable_entity
    end
  end
end
