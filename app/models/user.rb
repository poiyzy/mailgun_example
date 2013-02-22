class User < ActiveRecord::Base
  attr_accessible :email, :password, :fullname
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :fullname, presence: true
end
