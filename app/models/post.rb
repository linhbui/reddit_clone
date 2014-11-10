class Post < ActiveRecord::Base
  include Votable
  validates :title, :author, presence: true
  
  belongs_to :author, class_name: "User"  
  has_many :sub_posts, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :sub_posts, source: :sub
  has_many :comments, inverse_of: :post
  
  has_many(
      :top_level_comments,
      -> { where("parent_comment_id IS NULL") },
      class_name: "Comment"
  )
  
  def comments_by_parent
    results = Hash.new { |hash, key| hash[key] = [] }

    self.comments.includes(:author).each do |comment|
      results[comment.parent_comment_id] << comment
    end

    results
  end
  
end
