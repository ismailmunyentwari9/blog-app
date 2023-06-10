class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes, foreign_key: :post_id

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.update_posts_counter(author_id)
    author = User.find(author_id)
    author.posts.increment!(:comments_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
