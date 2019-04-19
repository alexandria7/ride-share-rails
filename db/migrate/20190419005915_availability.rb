class Availability < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :available, :boolean, :default => false
  end
end
