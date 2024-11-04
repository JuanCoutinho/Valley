class User < ApplicationRecord # rubocop:disable Style/Documentation
  has_many :projects
  has_many :posts
  attr_accessor :terms

  # Validação para garantir que os termos de uso foram aceitos
  validates :terms, acceptance: { message: 'Você deve aceitar os termos de uso' }
  has_many :notifications, dependent: :destroy
  has_one_attached :profile_image
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
