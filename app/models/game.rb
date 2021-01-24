class Game < ApplicationRecord
  
  belongs_to :user
  
  validates :date, presence: true
  validates :place, presence: true, length: { maximum: 50 }
  validates :enemy, presence: true, length: { maximum: 50 }
  validates :result, presence: true, length: { maximum: 10 }
  validates :topic, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 1000 }
  validate :pretend_future
  
  has_many :comments, dependent: :destroy

def pretend_future
  if date.present?
    errors[:base] <<  "今日以前の日付を入力してください。"  if date > Date.today
  end
end

end
