require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'json'

enable :sessions

# DB
require 'sinatra/activerecord'
require './environments'

# We're going to need to require our class files
require_relative('./models/post.rb')
require_relative('./models/blog.rb')

get '/' do
  @posts = Post.all
  erb :'posts/index', layout: :app
end

get '/posts/create' do
  @title = "Create post"
  erb :'posts/create', layout: :app
end

post '/posts' do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    redirect "posts/create"
  end
end