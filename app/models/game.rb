class Game < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :place, presence: true, length: { maximum: 50 }
  validates :enemy, presence: true, length: { maximum: 50 }
  validates :result, presence: true, length: { maximum: 10 }
  validates :topic, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 1000 }
end
