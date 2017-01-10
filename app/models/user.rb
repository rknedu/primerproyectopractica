require "concerns/permissions_concerns" 
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :comments
  include PermissionsConcerns
  def avatar
  	email_address = self.email.downcase
	hash = Digest::MD5.hexdigest(email_address)
	image_src = "https://www.gravatar.com/avatar/#{hash}"

  end
end
