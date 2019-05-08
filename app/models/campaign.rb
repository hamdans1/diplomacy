class Campaign < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :games, dependent: :destroy

  validates :title, length: {minimum: 3}, presence: true
  validates :scoring, length: {minimum: 3}, presence: true
  validates :group, presence: true
  validates :user, presence: true


end
