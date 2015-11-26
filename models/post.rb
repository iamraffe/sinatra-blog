require 'sinatra/activerecord'
class Post < ActiveRecord::Base
  def initialize(title, body)
    @title = title
    @body = body
  end

end