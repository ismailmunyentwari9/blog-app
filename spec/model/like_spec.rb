require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_likes_counter' do
    let!(:user) { User.create(name: 'John') }
    let!(:post) { Post.create(title: 'Test Post', text: 'Lorem ipsum dolor sit amet.', author: user) }
    let!(:like) { Like.create(post:, author: user) }

    it 'updates the likes_counter for the associated post' do
      expect do
        like.update_likes_counter
        post.save!
        post.reload
      end.to change { post.likes_counter }.from(0).to(1)
    end
  end
end
