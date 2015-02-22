class AddLatLongToCareCenters < ActiveRecord::Migration

 def self.up
  add_column :care_centers, :latitude, :float
  add_column :care_centers, :longitude, :float
 end

 def self.down
  remove_column :care_centers, :latitude, :float
  remove_column :care_centers, :longitude, :float
 end

end
