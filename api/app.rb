require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models'
require 'sinatra/basic_auth'
require_relative 'user_controler'
require 'rubygems'

set :database, { adapter: 'sqlite3', database: 'development.sqlite3' }
set :database, {adapter: "sqlite3", database: "auth.sqlite3"}

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  auth_data = Auth.all
  auth_data.any? { |data| [username, password] == [data.username, data.password] }
end

get '/' do
  @users = UserControler.show_users()
  erb :index
end

post '/user/create' do
  UserControler.create_user( 
    { 
      fname: params[:fname],
      lname: params[:lname],
      phone: params[:phone],
      city: params[:city],
      age: params[:age]
    } 
  ) 
  303
end

delete '/user/:id/delete' do
  UserControler.delete_user(params[:id])
  303
end

patch '/user/:id/edit' do 
  UserControler.edit_user(params[:id],
    { 
      fname: params[:fname],
      lname: params[:lname],
      phone: params[:phone],
      city: params[:city],
      age: params[:age]
    }
  ) 
  303
end
