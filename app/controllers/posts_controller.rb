class PostsController < ApplicationController
  # Get users/:user_id/posts
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:comments).where(author_id: params[:user_id])
  end

  # Get users/:user_id/posts/:id
  def show
    @user = User.find(params[:user_id])
    @post = Post.where(author_id: params[:user_id], id: params[:id])[0]
    @comments = Comment.where(post_id: params[:id])
  end

  # Get form
  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  # Create post
  def create
    user = current_user
    post = Post.new(post_params)

    post.author = user
    if post.save
      flash[:success] = 'Success: Your post has been saved'
      redirect_to root_path
    else
      post = Post.create
      flash[:error] = 'Error: Post could not be saved'
      render :new, locals: { post: }
    end
  end

  # Get users/:user_id/posts/:id
  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

    @post.comments.destroy_all
    @post.likes.destroy_all

    @post.destroy
    
    @user.post_counter -= 1;
    @user.save

    redirect_to "/users/#{params[:user_id]}"
  end

  def update_post_destroy_first
    post_counter = author.posts_counter
    post_counter -= 1
    User.find(author_id).update(posts_counter: post_counter)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end