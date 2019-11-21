class AddMessageSentToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :message_sent, :boolean
  end
end
