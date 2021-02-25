class Lane < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :bets, dependent: :destroy
end
