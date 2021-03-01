class User < ApplicationRecord
  before_validation :create_balance

  validates :username, presence: true, uniqueness: true

  has_many :entries, dependent: :destroy
  has_many :races, through: :lanes
  has_many :wins, dependent: :destroy
  has_many :bets, dependent: :destroy
  has_many :lanes, dependent: :destroy
  has_many :losses, dependent: :destroy
  has_one :habit, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_balance
    self.balance = 500
  end
end
