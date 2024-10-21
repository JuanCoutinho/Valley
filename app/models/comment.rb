class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user # Se você estiver usando um modelo User
  validates :body, presence: true
end
