class Entry < ApplicationRecord
  belongs_to :user

  FEELINGS = ['stressed', 'lonely', 'happy', 'bored', 'excited', 'down', 'angry', 'anxious']
  CONTEXT = ["I've just had an argument", "I've just finished eating", "I'm drinking a glass of alcohol", "I want to relax",
             "I'm at a concert", "i'm going to go to bed", "I'm taking a break", "I'm in a car", "I'm drinking a cup of coffee",
             "I'm at the phone", "I've made love", "I'm drinking a cup of tea", "I'm watching television", "I've just woken up", 
             "I'm working", "i'm in a bar", "I'm celebrating something", "I'm partying", "I'm with smokers", "I want to keep my hands busy", "I'm restless", "i'm missing the smell of cigarettes", "I'mmissing the taste of cigarettes", "I'm touching an object related to tobacco", "I'm taking a walk", "I'm hungry", "Nothing special", "Other"]

  validates :craving, numericality: { only_integer: true }, presence: true, inclusion: (0..10)
  validates :date, presence: true
  validates :feeling, presence: true, inclusion: FEELINGS
  validates :cig_smoked, presence: true, numericality: { only_integer: true }, inclusion: (0..50)
  validates :context, presence: true, inclusion: CONTEXT
end
