class UsersController < ApplicationController
  def index
    @recent_posts = User.all.map(&:recent_posts).flatten
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(created_at: :desc)
  end
end
