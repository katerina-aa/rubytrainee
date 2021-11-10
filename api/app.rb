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
  result = false
  auth_data.each { |data| result = true if [username, password] == [data.username, data.password] }
  result
end

get '/' do
  @users = UserControler.show_users()
  erb :index
end

post '/' do
  create_hash = {
    fname: params[:fname],
    lname: params[:lname],
    phone: params[:phone],
    city: params[:city],
    age: params[:age]
   }
  UserControler.create_user(create_hash)
  redirect '/'
end

delete '/user/:id/delete' do
  UserControler.delete_user(params[:id])
  redirect '/'
end

patch '/user/:id/edit' do 
  edit_hash = {
    fname: params[:fname],
    lname: params[:lname],
    phone: params[:phone],
    city: params[:city],
    age: params[:age]
    }
  UserControler.edit_user(params[:id], edit_hash) 
  redirect '/'
end

