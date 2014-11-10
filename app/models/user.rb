class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: :true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  after_initialize :generate_session_token!
  
  has_many :subs, foreign_key: :moderator_id
  has_many :posts, foreign_key: :author_id
  has_many :user_votes, inverse_of: :user
  has_many :comments, foreign_key: :author_id, inverse_of: :author
  
  attr_reader :password
  
  def generate_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
  end
  
  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(value)
  end
  
  def password_digest
    BCrypt::Password.new(super)
  end
  
  def is_password?(value)
    password_digest.is_password?(value)
  end
  
  def self.find_by_credentials(username, password)
   user = User.find_by(username: username)
   user.try(:is_password?, password) ? user : nil
  end
  
end
