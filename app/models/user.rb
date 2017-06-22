class User < ApplicationRecord

	# Make a token available without storing it in the database
	attr_accessor :remember_token

	before_save { self.email = email.downcase }
	has_many :messages
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :name, presence: true, length: { maximum: 50 }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	# Needed to create a test user fixture
	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Create a random token
	def self.new_token
		SecureRandom.urlsafe_base64
	end

	# Saves the token to the database as remember_digest
	def remember
		self.remember_token = User.new_token
		# Update attributes bypasses validation
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Compares remember_token (cookie) to remember_digest (db) and returns true if they match
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user after logout
	def forget
		update_attribute(:remember_digest, nil)
	end
end
