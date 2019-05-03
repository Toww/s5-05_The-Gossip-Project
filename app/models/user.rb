class User < ApplicationRecord
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
end
