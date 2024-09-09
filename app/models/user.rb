class User < ApplicationRecord
  has_many :projects
  has_one_attached :profile_image
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
