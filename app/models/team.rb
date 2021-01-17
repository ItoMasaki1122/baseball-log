class Team < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  
  has_many :favorites
  has_many :users, through: :favorites
  has_many :relikes, through: :favorites, source: :user
end
