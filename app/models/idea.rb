class Idea < ApplicationRecord
  has_many :reviews,-> { order('updated_at DESC') }, dependent: :destroy 
  belongs_to :user, optional: true

  has_many :likes
  has_many :likers, through: :likes, source: :user
 
  validates(:title, presence: true, uniqueness: true)
  validates :description, presence: true
end
