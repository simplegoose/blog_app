require 'rails_helper'

RSpec.describe 'Post/Index', type: :system do
  let(:user) do
    User.create(name: 'Harry', photo: 'https://photos.com/harrystyles', bio: 'harry Styles here!')
  end

  let(:post) do
    Post.create(author: user, text: 'text', title: 'First!')
  end

  let(:post2) do
    Post.create(author: user, text: 'text', title: 'Second!')
  end

  let(:post3) do
    Post.create(author: user, text: 'text', title: 'Third!')
  end

  let(:like) do
    Like.create(user: user, post: post)
  end

  let(:comment) do
    Comment.create(user: user, post: post, text: 'text')
  end

  before :each do
    user.save
    post.save
    post2.save
    post3.save
    like.save
    comment.save
  end
  

  describe 'Index page' do

    it 'I can see the user\'s profile pic.' do
      visit user_posts_path(user)
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    it 'I can see the user\'s profile name.' do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end

    it 'I can see the user\'s post count.' do
      visit user_posts_path(user)
      expect(page).to have_content(user.post_counter)
    end

    it 'I can see a post title.' do
      visit user_posts_path(user)
      expect(page).to have_content(post.title)
    end

    it 'I can see some of post body.' do
      visit user_posts_path(user)
      expect(page).to have_content(post.text)
      expect(page).to have_content(post2.text)
      expect(page).to have_content(post3.text)
    end

    it 'I can see a post comment.' do
      visit user_posts_path(user)
      expect(page).to have_content(comment.text)
    end

    it 'I can see how many comments a post has.' do
      visit user_posts_path(user)
      expect(page).to have_content(post.comments_counter)
    end

    it 'I can see how many likes a post has.' do
      visit user_posts_path(user)
      expect(page).to have_content(post.likes_counter)
    end

    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      visit user_posts_path(user)
      expect(page).to have_content('Pagination')
    end

    it 'I can visit post show page.' do
      visit user_posts_path(user)

      click_on "#{post.title}"

      expect(page).to have_content(post.title)
    end

  end
end