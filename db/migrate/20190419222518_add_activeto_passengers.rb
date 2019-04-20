class AddActivetoPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers , :active, :boolean, :default => true
  end
end
