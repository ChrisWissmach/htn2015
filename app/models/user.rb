class User < ActiveRecord::Base

	before_save :encrypt_password
	attr_accessor :password

	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :uniqueness => true
	validates :password, :confirmation => true #password_confirmation attr
	validates_length_of :password, :in => 6..20, :on => :create

	def self.authenticate(username, password)
		user = User.find_by_username(username)
		if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)
			return user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		end
  end
end
