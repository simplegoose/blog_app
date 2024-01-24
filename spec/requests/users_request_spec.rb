require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(name: 'Harry', photo: 'https://photos.com/harrystyles', bio: 'harry Styles here!')
  end

  before :each do
    user.save
  end

  describe 'Get /' do
    it 'Sends a success response' do
      get '/'

      expect(response).to have_http_status(:success)
    end

    it 'Renders the correct template' do
      get '/'

      expect(response).to render_template(:index)
    end

    it 'Renders the correct placeholder text in the index page' do
      get '/'

      expect(response.body).to include(user.name)
    end
  end

  describe 'Get /users/:id' do
    it 'Sends a success response' do
      get "/users/#{user.id}"

      expect(response).to have_http_status(:success)
    end

    it 'Renders the correct template' do
      get "/users/#{user.id}"

      expect(response).to render_template(:show)
    end

    it 'Renders the correct placeholder text in the show page' do
      get "/users/#{user.id}"

      expect(response.body).to include(user.name)
    end
  end
end
