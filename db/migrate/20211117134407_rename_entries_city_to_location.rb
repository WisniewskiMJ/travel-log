class RenameEntriesCityToLocation < ActiveRecord::Migration[6.1]
  def change
    rename_column :entries, :city, :location
  end
end
