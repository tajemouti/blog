class Api::PostsController < ApiController
  def index
    @user = User.find(params[:user_id])
  end
end
