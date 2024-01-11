require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'Timothy', bio: 'Hello! new user here', photo: 'https://dropbox/users/timothy/profilepic.webp')
    @user.save
    @post = Post.create(author: @user, title: 'String', text: 'Text')
  end

  it 'Title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'Comment counter should have a value greater than or equal to zero' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'Likes counter should have a value greater than or equal to zero' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  it 'Recent comments method should return three most recent post' do
    Comment.create(user: @user, post: @post, text: 'Text')
    Comment.create(user: @user, post: @post, text: 'Text')
    Comment.create(user: @user, post: @post, text: 'Text')
    Comment.create(user: @user, post: @post, text: 'Text')
    Comment.create(user: @user, post: @post, text: 'Text')

    expect(@post.recent_comments.length).to eq(5)
  end

  it 'Increment post count on user' do
    expect(@user.post_counter).to eq(1)
  end
end
