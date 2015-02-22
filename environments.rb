configure :development do
 set :database, 'postgres:///early_childhood_development'
 set :show_exceptions, true
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'])

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end