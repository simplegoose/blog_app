class PostsController < ApplicationController
  # Get users/:user_id/posts
  def index
    @posts = Post.where(author_id: params[:user_id])
  end

  #Get users/:user_id/posts/:id
  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id])
  end
end
