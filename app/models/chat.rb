class Chat < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :user_open_chat, class_name: 'User'
  belongs_to :user_destination_chat, class_name: 'User'

  has_many :chat_messages
end
