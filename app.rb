require 'sinatra'
require 'sinatra/reloader'
# require 'pry'
require 'json'
require 'sinatra/disqus'
# DB
require 'sinatra/activerecord'
require './environments'

# We're going to need to require our class files
require_relative('./models/post.rb')
# require_relative('./models/blog.rb')
require_relative('./models/user.rb')

#Blog as a controller
class Blog
  def posts
    Post.order("created_at DESC")
  end

  def add_post(post)
    Post.new(post)
  end

  def view_post(id)
    Post.find(id)
  end

  def view_author(id)
    User.find(id)
  end
end

after { ActiveRecord::Base.connection.close }

helpers do
  # define a current_user method, so we can be sure if an user is authenticated
  def current_user
    @current_user ||= User.find_by(uid: session[:uid])
  end

  # def user_profile_picture_path
  #   if current_user.provider == "facebook"
  #     profile_picture_path = "#{current_user.image}?type=large"
  #   else
  #     profile_picture_path = "#{current_user.image}"
  #   end
  #   profile_picture_path
  # end
end

sinatra_blog = Blog.new

get '/' do
  @posts = sinatra_blog.posts
  erb :'posts/index', layout: :app
end

get '/posts/create' do
  redirect to('/auth/login') unless current_user
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

get '/auth/:provider/callback' do
  # probably you will need to create a user in the database too...
  @user = User.from_omniauth(env['omniauth.auth'].except("extra"))
  if @user.persisted? || @user.save
    session[:uid] = env['omniauth.auth']['uid']
    redirect to('/')
  else
    redirect to('/')
  end
end

get '/auth/failure' do
  # omniauth redirects to /auth/failure when it encounters a problem
  # so you can implement this as you please
end

get '/auth/login' do
  session.clear
   erb :'auth/login', layout: :app
end

get '/auth/logout' do
  session.clear
  redirect to('/')
end

get '/users/:id' do
  @user = sinatra_blog.view_author(params[:id])
  @title = @user.name
  erb :'users/view', layout: :app
end

get '/localhost' do
  redirect '127.0.0.1:9292'
end
