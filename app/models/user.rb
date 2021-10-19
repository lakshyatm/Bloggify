class User < ApplicationRecord
  before_save { self.email = email.downcase }
  #association         delete the dependent articles if user delted
  has_many :articles , dependent: :destroy
  has_one_attached :image  

  has_many :messages
  validates :username,presence: true, uniqueness: { case_sensitive: false },length: {minimum:3,maximum:25}

  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true, uniqueness: { case_sensitive: false }, length: {maximum:125}, format: { with: VALID_EMAIL_REGEX}

  has_secure_password
end