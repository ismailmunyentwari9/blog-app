require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John') }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }
  subject { Comment.new(post:, author: user) }

  describe '.update_comments_counter' do
    it 'increments the comments_counter of the associated post' do
      expect { Comment.update_comments_counter(post.id) }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
