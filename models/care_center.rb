class CareCenter < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
  geocoded_by :address
  after_validation :geocode
  validates_presence_of :address, :name

  def self.nearest_centers(lat_long)
    CareCenter.near(lat_long, 1).limit(3)
  end

end