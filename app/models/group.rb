class Group < ApplicationRecord
  has_many :campaigns, dependent: :destroy
end
