require 'sinatra'
require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: 'development.sqlite3' }

get '/' do
  @users = User.all
  erb :index
end

require_relative 'models.rb'
