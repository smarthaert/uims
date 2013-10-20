require 'digest/sha2'
#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Customer < ActiveRecord::Base
  #attr_accessible :loginname, :password, :password_confirmation, :cid, :cname, :shopname, :sex, :address, :email, :qq, :tel, :state 
  attr_accessible :address, :cdate, :cid, :cname, :email, :loginname, :qq, :remark, :sex, :shopname, :state, :tel, :password, :password_confirmation
  validates :loginname, presence: true, uniqueness: true
#  has_secure_password
  has_one :cart
  has_many :ordermain
  after_destroy :ensure_an_admin_remains

  validates :password, :confirmation => true

  attr_accessor :password_confirmation
  attr_reader :password
  validate :password_must_be_present

	class << self
		def authenticate(name, password)
			if user = find_by_loginname(name)
				if user.hashed_password == encrypt_password(password, user.salt)
					user
				end
			end
		end
		def encrypt_password(password, salt)
			Digest::SHA2.hexdigest(password + "wibble" + salt)
		end
	end
	
	# 'password' is a virtual attribute
	def password=(password)
		@password = password
		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end

	private
	def password_must_be_present
		errors.add(:password, "Missing password") unless hashed_password.present?
	end
	
	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

  private
    def ensure_an_admin_remains
      if Customer.count.zero?
        raise "Can't delete last customer"
      end
    end     
end
