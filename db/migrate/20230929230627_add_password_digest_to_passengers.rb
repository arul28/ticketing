class AddPasswordDigestToPassengers < ActiveRecord::Migration[7.0]
  def change
    add_column :passengers, :password_digest, :string
  end
end
