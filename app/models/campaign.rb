class Campaign < ApplicationRecord
  belongs_to :group
  has_many :games, dependent: :destroy
end
