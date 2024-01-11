require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.new(name: 'Timothy', bio: 'Hello! new user here', photo: 'https://dropbox/users/timothy/profilepic.webp')
    @user.save
    @post = Post.create(author: @user, title: 'String', text: 'Text')
    @post.save
    @comment = Comment.create(user: @user, post: @post)
  end

  it 'Increment comment count on post' do
    expect(@post.comments_counter).to eq(1)
  end
end
