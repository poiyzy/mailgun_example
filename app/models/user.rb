class User < ActiveRecord::Base
  has_secure_password

  has_many :issues

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :fullname, presence: true
end
