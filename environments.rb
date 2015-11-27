require 'dotenv'
Dotenv.load

require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-google-oauth2'
require 'sinatra/disqus'

configure do
  enable :sessions

  use OmniAuth::Builder do
    provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], {:image_size => 'original'}
    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], {:image_size => 'large'}
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {:image_size => 150}
  end
end

configure :test do
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'test_application.sqlite3.db'
)
end

configure :development do
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'sinatra_application.sqlite3.db'
)
set :disqus_shortname, "localhost:4567"
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
  # Disqus settings
  set :disqus_shortname, "example.org"
end
