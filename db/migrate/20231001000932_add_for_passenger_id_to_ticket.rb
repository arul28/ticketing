class AddForPassengerIdToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :for_passenger_id, :string
  end
end
