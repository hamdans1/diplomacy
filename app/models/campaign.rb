class Campaign < ApplicationRecord
  belongs_to :group
  has_many :games, dependent: :destroy

  validates :title, length: {minimum: 3}, presence: true
  validates :scoring, length: {minimum: 3}, presence: true
  validates :group, presence: true
  
end
