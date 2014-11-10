 class SubsController < ApplicationController
  before_action :require_login
  
  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit  
    @sub = Sub.find(params[:id])
    redirect_to subs_path unless user_is_creator?(@sub, :moderator_id)
  end

  def update
    @sub = Sub.find(params[:id])
    redirect_to subs_path unless user_is_creator?(@sub, :moderator_id)
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end  
  end
  
  def downvote; vote(-1); end
  def upvote; vote(1); end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def vote(dir)
    @sub = Sub.find(params[:id])
    @user_vote = UserVote.find_by(
      votable_id: @sub.id, votable_type: "Sub", user_id: current_user.id
    )

    if @user_vote
      @user_vote.update(value: dir)
    else
      @sub.user_votes.create!(
        user_id: current_user.id, value: dir
      )
    end

    redirect_to sub_url(@sub)
  end 
end