class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :entries, dependent: :destroy
  has_one :habit, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
