class Notification < ApplicationRecord
  belongs_to :user
  scope :unread, -> { where(read: false) }
  belongs_to :comment, optional: true
end
