class LikesController < ApplicationController
  def create
    user = current_user
    post = Post.find(params[:post_id])
    like = Like.new(user:, post:)
    puts like

    if like.save
      flash[:success] = 'Success: Your like has been saved'
      redirect_to "/users/#{params[:author_id]}/posts/#{params[:post_id]}"
    else
      flash[:error] = 'Error: Like could not be saved'
      redirect_to users_home_path
    end
  end
end
