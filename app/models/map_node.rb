class MapNode < ActiveRecord::Base
  has_and_belongs_to_many :source_paths,
                          :join_table => 'map_paths',
                          :foreign_key => 'source_id',
                          :association_foreign_key => 'dest_id',
                          :class_name => 'MapNode'
  has_and_belongs_to_many :dest_paths,
                          :join_table => 'map_paths',
                          :foreign_key => 'dest_id',
                          :association_foreign_key => 'source_id',
                          :class_name => 'MapNode'
  has_many :npcs
end
