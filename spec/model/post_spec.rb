require 'rails_helper'
RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John') }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#recent_comments' do
    let!(:post) { Post.create(title: 'Test Post', author: user) }
    let!(:comment1) { Comment.create(content: 'Comment 1', post:) }
    let!(:comment2) { Comment.create(content: 'Comment 2', post:) }
    let!(:comment3) { Comment.create(content: 'Comment 3', post:) }
    let!(:comment4) { Comment.create(content: 'Comment 4', post:) }
    let!(:comment5) { Comment.create(content: 'Comment 5', post:) }
    let!(:comment6) { Comment.create(content: 'Comment 6', post:) }

    it 'returns the most recent 5 comments for the post' do
      expect(post.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end

  describe '.update_posts_counter' do
    let!(:post1) { Post.create(title: 'Post 1', author: user) }
    let!(:post2) { Post.create(title: 'Post 2', author: user) }

    it 'increments the comments_counter for all posts by the given author' do
      expect { Post.update_posts_counter(user.id) }.to change { post1.reload.comments_counter }.by(1)
        .and change { post2.reload.comments_counter }.by(1)
    end
  end
end
