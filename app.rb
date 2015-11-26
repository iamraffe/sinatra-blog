require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'json'


# DB
require 'active_record'
require './environments'

# We're going to need to require our class files
require_relative('./models/post.rb')
# require_relative('./models/todolist.rb')

get '/' do
  @posts = Post.all
  # erb :"tasks/index", layout: :app
  erb :index, layout: :app
end