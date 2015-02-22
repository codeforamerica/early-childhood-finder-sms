class CreateCareCenters < ActiveRecord::Migration

 def self.up
   create_table :care_centers do |t|
     t.string :name
     t.string :address
     t.string :phone
     t.string :email
     t.timestamps null: false
   end
 end

 def self.down
   drop_table :care_centers
 end

end
