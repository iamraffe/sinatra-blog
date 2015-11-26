require 'sinatra'
require 'sinatra/reloader'
# require 'pry'
require 'json'

enable :sessions

# DB
require 'sinatra/activerecord'
require './environments'

# We're going to need to require our class files
require_relative('./models/post.rb')
require_relative('./models/blog.rb')

after { ActiveRecord::Base.connection.close }

sinatra_blog = Blog.new

get '/' do
  @posts = sinatra_blog.posts
  erb :'posts/index', layout: :app
end

get '/posts/create' do
  @title = "Create post"
  erb :'posts/create', layout: :app
end

post '/posts' do
  @post = sinatra_blog.add_post(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    redirect "posts/create"
  end
end

get "/posts/:id" do
  @post = sinatra_blog.view_post(params[:id])
  @title = @post.title
  erb :'posts/view', layout: :app
end