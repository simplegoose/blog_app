class PostsController < ApplicationController
  # Get users/:user_id/posts
  def index
    @user = User.find(params[:user_id])
  end

  # Get users/:user_id/posts/:id
  def show
    @user = User.find(params[:user_id])
    @post = Post.where(author_id: params[:user_id], id: params[:id])[0]
  end
end
