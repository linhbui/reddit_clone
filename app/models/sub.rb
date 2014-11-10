class Sub < ActiveRecord::Base
  include Votable
  validates :title, :moderator, :description, presence: true
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id
  )
  
  has_many :sub_posts, inverse_of: :sub
  has_many :posts, through: :sub_posts, source: :post
  
end
