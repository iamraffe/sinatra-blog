require 'sinatra/activerecord'
class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy

  def self.from_omniauth(omniauth)
    user = where(provider: omniauth.provider, uid: omniauth.uid).first || where(:email => omniauth.info.email).first || new 
    user.provider = omniauth.provider
    user.uid = omniauth.uid
    user.email = omniauth.info.email
    user.name = omniauth.info.name   
    user.image = omniauth.info.image
    user
  end
end