class User < ApplicationRecord
  has_many :campaigns

  before_save {self.email = email.downcase if email.present?}
  before_save {self.role ||= :member}

  validates :name, length: { minimum: 3, maximum: 25 }, presence: true

  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :password, length: { minimum: 8 }, allow_blank: true

  validates :email, length: {minimum: 7}, presence: true, uniqueness: { case_sensitive: false}

  has_secure_password

  enum role: [:member, :admin]
  
end
