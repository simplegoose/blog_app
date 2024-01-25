require 'rails_helper'

RSpec.describe 'Users/Index', type: :system do
  let(:user) do
    User.create(name: 'Harry', photo: 'https://photos.com/harrystyles', bio: 'harry Styles here!')
  end

  let(:user2) do
    User.create(name: 'Mathew', photo: 'https://photos.com/matstyles', bio: 'Mat Styles here!')
  end

  let(:user3) do
    User.create(name: 'Jim', photo: 'https://photos.com/jimcarrey', bio: 'Jim Carrey here!')
  end

  before :each do
    user.save
    user2.save
    user3.save
  end

  describe 'Index page' do
    it 'I can see the username of all other users.' do
      visit users_path
      expect(page).to have_content(user.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(user3.name)
    end

    it 'I can see the profile pic of all other users.' do
      visit users_path
      expect(page).to have_css("img[src*='#{user.photo}']")
      expect(page).to have_css("img[src*='#{user2.photo}']")
      expect(page).to have_css("img[src*='#{user3.photo}']")
    end

    it 'I can see the number of posts of all other users.' do
      visit users_path
      expect(page).to have_content(user.post_counter)
      expect(page).to have_content(user2.post_counter)
      expect(page).to have_content(user3.post_counter)
    end

    it 'I can visit user show page.' do
      visit users_path

      click_on user.name.to_s

      expect(page).to have_content(user.bio)
    end
  end
end
