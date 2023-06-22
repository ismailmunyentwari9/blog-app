class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = @user.posts.includes(:comments).order(created_at: :desc)
    @recent_comments = @user_posts.flat_map(&:recent_comments)
  end

  def show
    @user = User.find(params[:user_id])
    @user_post = @user.posts.find(params[:id])
    @author_id = current_user.id
    @post_index = @user.posts.order(created_at: :desc).pluck(:id).index(@user_post.id) + 1
    @likes_count = @user_post.likes_counter
    @comments_count = @user_post.comments_counter
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_url(user_id: @post.author_id)
    else
      render :new
    end
  end

  def create_comment
    @user_post = Post.find(params[:id])
    @comment = @user_post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(user_id: @user_post.author_id, id: @user_post.id), notice: 'Comment created successfully.'
    else
      redirect_to user_post_path(user_id: @user_post.user.id, id: @user_post.id), alert: 'Failed to create comment.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end

  def comment_params
    params.require(:comment).permit(:post_id, :text)
  end
end
