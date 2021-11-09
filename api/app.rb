require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models'
require 'sinatra/basic_auth'
require_relative 'user_controler'

set :database, { adapter: 'sqlite3', database: 'development.sqlite3' }

auth_data = { aadmin: "admin" }

authorize do |username, password|
  auth_data[username.to_sym] == password
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

protect do
  delete '/user/:id/delete' do
    UserControler.delete_user(params[:id])
    redirect '/'
  end
end

protect do
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
end
