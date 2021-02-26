class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :lane

  validates :amount, presence: true
  validates :lane_id, presence: true

  has_one :race, through: :lane
end
