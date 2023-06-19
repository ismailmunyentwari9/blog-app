require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'renders the index template and includes correct placeholder text' do
      # make get request
      get '/users'
      # check response body/status
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      
    end
  end
  describe 'GET /show' do
    it 'renders the show template and includes correct placeholder text' do
      user = User.create!(name: 'John', posts_counter: 12)
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
