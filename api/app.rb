require 'sinatra'
require 'sinatra/basic_auth'
require_relative 'user_controller'
require 'rubygems'
require_relative 'models'

set :database, { adapter: 'sqlite3', database: 'development.sqlite3' }

=begin
use Rack::Auth::Basic, "Restricted Area" do |username, password|
  auth_data = Auth.all
  auth_data.any? { |data| [username, password] == [data.username, data.password] }
=end

get '/' do
  @users = UserController.show_users()
  erb :index 
end

get '/user/:id/get' do
  UserController.get_user(params[:id])
  333
end

post '/user/create' do
  @user = UserController.create_user( 
    { 
      fname: params[:fname],
      lname: params[:lname],
      phone: params[:phone],
      city: params[:city],
      age: params[:age]
    } 
  ) 
  @user.errors.empty? ? 333 : 444
end

delete '/user/:id/delete' do
  UserController.delete_user(params[:id])
  333
end

patch '/user/:id/edit' do 
  @user = UserController.edit_user(params[:id],
    { 
      fname: params[:fname],
      lname: params[:lname],
      phone: params[:phone],
      city: params[:city],
      age: params[:age]
    }
  ) 
  @user.errors.empty? ? 333 : 444
end

error 444 do
  "#{@user.errors.messages}"
end
