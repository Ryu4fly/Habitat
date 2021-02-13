class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :avg_cig, presence: true, numericality: { only_integer: true }
  validates :cost_a_pack, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
