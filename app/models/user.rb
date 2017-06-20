class User < ApplicationRecord
	has_many :messages
	validates :email, presence: true
	validates :name, presence: true 
end
