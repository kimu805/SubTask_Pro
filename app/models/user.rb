class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # association
  has_many :tasks, dependent: :destroy
  has_many :priorities, dependent: :destroy
  has_one :subscription

  # enum
  enum :role, [ :free, :paid, :admin ]
end
