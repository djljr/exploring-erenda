class CreateNpcs < ActiveRecord::Migration
  def self.up
    create_table :npcs do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :map_node, :int
    end
  end

  def self.down
    drop_table :npcs
  end
end
