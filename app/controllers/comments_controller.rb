class CommentsController < ApplicationController
  def new
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def create
    puts params
    user = current_user
    post_id = params[:post_id]
    post = Post.find(post_id)
    comment = Comment.new(comment_params)
    comment.user = user
    comment.post = post

    if comment.save
      flash[:success] = 'Success: Your comment has been saved'
      redirect_to users_path
    else
      Comment.create
      flash[:error] = 'Error: Comment could not be saved'
      render :new, locals: { comment: }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
