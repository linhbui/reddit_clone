class DeleteUserVotesColumn < ActiveRecord::Migration
  def change
    remove_column :user_votes, :user_votes
  end
end
