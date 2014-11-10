class PostsController < ApplicationController
  before_action :require_login, except: :show
  before_action :require_user_being_creator, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors
      render :update
    end
  end
  
  def downvote; vote(-1); end
  def upvote; vote(1); end
  
  private
    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end
    
    def require_user_being_creator
      @post = Post.find(params[:id])
      redirect_to subs_path unless user_is_creator?(@post, :author_id)
    end
    
    def vote(dir)
      @post = Post.find(params[:id])
      @user_vote = UserVote.find_by(
        votable_id: @post.id, votable_type: "Post", user_id: current_user.id
      )

      if @user_vote
        @user_vote.update(value: dir)
      else
        @post.user_votes.create!(
          user_id: current_user.id, value: dir
        )
      end

      redirect_to post_url(@post)
    end
end
