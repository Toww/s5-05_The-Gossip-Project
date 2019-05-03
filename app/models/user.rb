class User < ApplicationRecord
	attr_accessor :remember_token

	belongs_to :city
	has_many :gossips
	has_many :comments
	has_many :likes
	has_secure_password

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :description, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "please put a real e-mail address" }
	validates :age, presence: true
	validates :city, presence: true
	validates :password, presence: true, length: { minimum: 6 }

	# On prépare la méthode User.digest
	class << self
    # Returns the hash digest of the given string.
    def digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    	BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
    	SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

   # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget 
  	update_attribute(:remember_digest, nil)
  end

end
