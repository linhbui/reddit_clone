class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id, null: false
      t.integer :value, null: false
      t.integer :user_votes, :voteable_id, null: false
      t.string :user_votes, :voteable_type, null: false
      t.timestamps
    end

    add_index :user_votes, [:voteable_id, :voteable_type]
    add_index :user_votes, [:user_id, :voteable_id, :voteable_type], unique: true
  end
end
