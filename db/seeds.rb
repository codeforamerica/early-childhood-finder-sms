require 'csv'

CareCenter.destroy_all
CSV.foreach("somerville.csv") do |row|
  CareCenter.create(name: row[0], address: row[1], phone: row[2], email: row[3])
end

