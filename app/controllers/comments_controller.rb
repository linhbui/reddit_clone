class CommentsController < ApplicationController
  before_action :require_login, except: :show
  
  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    post_id = @comment.post_id
    if @comment.save
      redirect_to post_url(post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment_url(post_id)
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
    @new_comment = Comment.new(
      post_id: @comment.post_id, parent_comment_id: @comment.id
    )
    render :show
  end
  
  def downvote; vote(-1); end
  def upvote; vote(1); end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
  
  def vote(dir)
    @comment = Comment.find(params[:id])
    @user_vote = UserVote.find_by(
      votable_id: @comment.id, votable_type: "Comment", user_id: current_user.id
    )

    if @user_vote
      @user_vote.update(value: dir)
    else
      @comment.user_votes.create!(
        user_id: current_user.id, value: dir
      )
    end

    redirect_to post_url(@comment.post)
  end
end
