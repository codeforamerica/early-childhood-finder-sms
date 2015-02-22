require "./finder"
require "sinatra/activerecord/rake"

namespace :csv do
  task :parse do
    if File.exist?('public/somerville.csv')
      CSV.foreach("public/somerville.csv") do |row|
        CareCenter.create(name: row[0], address: row[1], phone: row[2], email: row[3])
      end
    end
  end
end