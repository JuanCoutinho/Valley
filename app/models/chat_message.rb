class ChatMessage < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :chat
  belongs_to :sender, class_name: 'User'
end
