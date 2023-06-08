class Comment < ApplicationRecord
  belongs_to :post

  def self.update_comments_counter(post_id)
    post = Post.find(post_id)
    post.update(comments_counter: post.comments.count)
  end
end
