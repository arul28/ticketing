class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.decimal :rating
      t.text :feedback

      t.timestamps
    end
  end
end
