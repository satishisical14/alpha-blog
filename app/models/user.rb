class User < ApplicationRecord
	validates :username, presence: true, 
						uniqueness: { case_sensitive: false }, 
						length: { minimum: 3, maximum: 10 }
	VALID_EMAIL_REGEX = /([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})/i
	validates :email, presence: true, 
						uniqueness: { case_sensitive: false }, 
						length: { maximum: 10 },
						format: { with: VALID_EMAIL_REGEX }
end