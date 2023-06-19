RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'renders the index template and includes correct placeholder text' do
      user = User.create!(name: 'John Doe', posts_counter: 0) # Provide valid values for name and posts_counter
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'renders the show template and includes correct placeholder text' do
      user = User.create!(name: 'John Doe', posts_counter: 0) # Provide valid values for name and posts_counter
      post = user.posts.create!(title: 'Post Title', text: 'Post Text') # Create a post associated with the user
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
