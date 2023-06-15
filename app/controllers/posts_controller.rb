class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = @user.posts.order(created_at: :desc)
    @recent_comments = @user_posts.map(&:recent_comments).flatten
  end

  def show
    @user = User.find(params[:user_id])
    @user_post = @user.posts.find(params[:id])
    @post_index = @user.posts.order(created_at: :desc).pluck(:id).index(@user_post.id) + 1
    @likes_count = @user_post.likes_counter
    @comments_count = @user_post.comments_counter
  end
end
