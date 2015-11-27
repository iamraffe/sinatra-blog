require 'sinatra/activerecord'
class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
  validates :user_id, presence: true
  belongs_to :user
end