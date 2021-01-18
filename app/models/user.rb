class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduce, presence: true, length:{ maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :games
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :team
  
  def favorite(one_team)
    self.favorites.find_or_create_by!(team_id: one_team.id)
  end
  
  def favchange(one_team)
    self.favorites.each do |fav|
      fav.update!(team_id: one_team.id)
    end
  end
  
  def like?(one_team)
    self.likes.include?(one_team)
  end
end
