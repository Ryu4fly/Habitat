class Race < ApplicationRecord
  has_one :win
  has_many :losses, dependent: :destroy
  has_many :lanes, dependent: :destroy
end
