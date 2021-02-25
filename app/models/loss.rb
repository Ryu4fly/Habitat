class Loss < ApplicationRecord
  belongs_to :user
  belongs_to :race

  validates :placing, numericality: { only_integer: true, greater_than: 1 }
end
