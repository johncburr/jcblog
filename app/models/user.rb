# == Schema Information
# Schema version: 20110520173756
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  pepper     :string(255)
#  salt       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :user_type, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password, :set_user_type

  has_many  :blogposts

  validates :name,      :presence => true, 
                        :length => {:maximum => 48}
  validates :email,     :presence => true, 
                        :uniqueness => true,
                        :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password,  :presence => true,
                        :confirmation => true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.pepper == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.pepper = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def set_user_type(ut = 0)
    if !User.find_by_user_type(13).nil?
      self.user_type ||= ut
    else
      self.user_type = 13
    end
  end
end