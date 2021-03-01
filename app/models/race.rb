class Race < ApplicationRecord
  has_one :win
  has_many :losses, dependent: :destroy
  has_many :lanes, dependent: :destroy
  has_many :users, through: :lanes
  has_many :bets, through: :lanes

  MONTHS = [nil, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
end
