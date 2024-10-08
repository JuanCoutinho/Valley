class EnableUuid < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    enable_extension 'pgcrypto'
  end
end
