class Notification < ApplicationRecord
  belongs_to :user
  validates :message, presence: true
  scope :unread, -> { where(read: false) }
  belongs_to :comment, optional: true
end
