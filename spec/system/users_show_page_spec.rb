require 'rails_helper'

RSpec.describe 'Users/Show', type: :system do
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

  before :each do
    user.save
    post.save
    post2.save
    post3.save
  end

  describe 'Show page' do
    it 'I can see the user\'s profile pic.' do
      visit user_path(user)
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    it 'I can see the user\'s profile name.' do
      visit user_path(user)
      expect(page).to have_content(user.name)
    end

    it 'I can see the user\'s post count.' do
      visit user_path(user)
      expect(page).to have_content(user.post_counter)
    end

    it 'I can see the user\'s bio.' do
      visit user_path(user)
      expect(page).to have_content(user.bio)
    end

    it 'I can see the user\'s first three posts.' do
      visit user_path(user)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post3.title)
    end

    it 'I can visit user post show page.' do
      visit user_path(user)

      click_on post.title.to_s

      expect(page).to have_content(post.title)
    end
  end
end
