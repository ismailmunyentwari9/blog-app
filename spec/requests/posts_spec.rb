require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'renders the index template and includes correct placeholder text' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('..ALL POSTS')
    end
  end

  describe 'GET /show' do
    it 'renders the show template and includes correct placeholder text' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include('...POST FROM POSTS LISTS')
    end
  end
end
