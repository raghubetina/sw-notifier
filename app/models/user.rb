class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates :phone_number, :presence => true
  has_secure_password

  has_many :flights
end
