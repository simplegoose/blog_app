class UsersController < ApplicationController
  # Get /users/
  def index
    @users = User.all
  end

  # Get /users/:id
  def show
    @user = User.find(params[:id])
  end
end
