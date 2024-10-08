class Like < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :user
  belongs_to :project
end
