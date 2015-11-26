require 'sinatra'
require 'sinatra/reloader'
require 'pry'


# DB
require 'sinatra/activerecord'
require './environments'

# We're going to need to require our class files
require_relative('./models/post.rb')
# require_relative('./models/todolist.rb')

get '/' do
  @posts = Post.all
  binding.pry
  # erb :"tasks/index", layout: :app
  erb :index, layout: :app
end