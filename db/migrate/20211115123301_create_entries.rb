class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.string :city, null: false
      t.integer :temperature, null: false
      t.text :note, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
