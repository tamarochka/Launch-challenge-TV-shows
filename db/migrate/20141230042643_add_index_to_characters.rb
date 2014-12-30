class AddIndexToCharacters < ActiveRecord::Migration
  def change
    add_index :characters, [:name, :television_show_id], unique: true
  end
end
