require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) do
    User.create(name: 'Harry', photo: 'https://photos.com/harrystyles', bio: 'harry Styles here!')
  end

  let(:post) do
    Post.create(author: user, text: 'Hello world!', title: 'First post!')
  end

  before :each do
    user.save
    post.save
  end

  describe 'Get /users/:id/post' do
    it 'Sends a success response' do
      get "/users/#{user.id}/posts"

      expect(response).to have_http_status(:success)
    end

    it 'Renders the correct template' do
      get "/users/#{user.id}/posts"

      expect(response).to render_template(:index)
    end

    it 'Renders the correct placeholder text in the index page' do
      get "/users/#{user.id}/posts"

      expect(response.body).to include(user.name)
    end
  end

  describe 'Get /users/:id/posts/:id' do
    it 'Sends a success response' do
      get "/users/#{user.id}/posts/#{post.id}"

      expect(response).to have_http_status(:success)
    end

    it 'Renders the correct template' do
      get "/users/#{user.id}/posts/#{post.id}"

      expect(response).to render_template(:show)
    end

    it 'Renders the correct placeholder text in the show page' do
      get "/users/#{user.id}/posts/#{post.id}"

      expect(response.body).to include(post.text)
    end
  end
end
