class Game < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  validates :title, length: {minimum: 4}, presence: true
  validates :scoring, presence: true
  validates :map, length: { minimum: 3}, presence: true
  validates :style, presence: true
end
