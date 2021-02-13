class Entry < ApplicationRecord
  belongs_to :user

  FEELINGS = ['stressed', 'lonely', 'happy', 'bored', 'excited', 'down', 'angry', 'anxious']

  validates :craving, numericality: { only_integer: true }, presence: true, inclusion: (1..10)
  validates :date, presence: true
  validates :feeling, presence: true, inclusion: FEELINGS
end
