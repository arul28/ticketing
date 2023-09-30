class AddRatingToTrains < ActiveRecord::Migration[7.0]
  def change
    add_column :trains, :rating, :decimal
  end
end
