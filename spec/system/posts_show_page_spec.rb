require 'rails_helper'

RSpec.describe 'Post/Show', type: :system do
  let(:user) do
    User.create(name: 'Harry', photo: 'https://photos.com/harrystyles', bio: 'harry Styles here!')
  end

  let(:user2) do
    User.create(name: 'Niall', photo: 'https://photos.com/niall', bio: 'Niall here!')
  end

  let(:post) do
    Post.create(author: user, text: 'text', title: 'First!', likes_counter: 1)
  end

  let(:like) do
    Like.create(user: user, post: post)
  end

  let(:comment) do
    Comment.create(user: user, post: post, text: 'text')
  end

  let(:comment2) do
    Comment.create(user: user2, post: post, text: 'text')
  end

  before :each do
    user.save
    user2.save
    post.save
    like.save
    comment.save
    comment2.save
  end
  
  describe 'Show page' do

    it 'I can see a post title.' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.title)
    end

    it 'I can see who wrote the post.' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.author.name)
    end

    it 'I can see how many comments a post has.' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.comments_counter)
    end

    it 'I can see how many likes a post has.' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.likes_counter)
    end

    it 'I can see a post body.' do
      visit user_post_path(user, post)
      expect(page).to have_content(post.text)
    end

    it 'I can see username of each commenter.' do
      visit user_post_path(user, post)
      expect(page).to have_content(comment.user.name)
      expect(page).to have_content(comment2.user.name)
    end

    it 'I can see comment of each user.' do
      visit user_post_path(user, post)
      expect(page).to have_content(comment.text)
      expect(page).to have_content(comment2.text)
    end

  end
end