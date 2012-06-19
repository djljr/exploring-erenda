class CreateMapNodes < ActiveRecord::Migration
  def self.up
    create_table :map_nodes do |t|
      t.column :name, :string, :limit => 100
      t.column :description, :string, :limit => 400
      t.column :text, :string, :limit => 4000
    end
    create_table :map_paths, :id => false do |t|
      t.column :source_id, :int
      t.column :dest_id, :int
    end
  end

  def self.down
    drop_table :map_nodes
    drop_table :map_paths
  end
end
