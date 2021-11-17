class AddGeocoordinatesToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :latitude, :float, null: false
    add_column :entries, :longitude, :float, null: false
  end
end
