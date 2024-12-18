class Project < ApplicationRecord # rubocop:disable Style/Documentation
  has_one_attached :image
  has_one_attached :images
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :user # Assumindo que um projeto pertence a um usuário
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user)
    liked_users.include?(user)
  end

  def update_likes_count
    update_column(:likes_count, likes.count)
  end
  
end
