class Group < ApplicationRecord
  has_many :campaigns, dependent: :destroy

  validates :name, length: {minimum: 3}, presence: true
  validates :description, length: {minimum: 10}, presence: true
  validates :public, presence: true


end
