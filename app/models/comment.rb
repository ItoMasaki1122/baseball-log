class Comment < ApplicationRecord
  validates :content, presence: true, length: {maximum: 40}
  
  belongs_to :user
  belongs_to :game
end
