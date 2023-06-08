class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def self.update_posts_counter(author_id)
    author = User.find(author_id)
    author.posts.increment!(:comments_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
