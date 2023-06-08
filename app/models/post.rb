class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  def self.update_posts_counter(user_id)
    user = User.find(user_id)
    user.posts.update_all(comments_counter: user.posts.joins(:comments).distinct.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
