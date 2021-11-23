require 'sinatra'
#require 'sinatra/basic_auth'
require_relative 'user_controller'
require 'rubygems'
require_relative 'models'

set :database, { adapter: 'sqlite3', database: 'development.sqlite3' }

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  auth_data = Auth.all
  puts auth_data.first.username
  auth_data.any?{ |data| (username == data.username) && (password == data.password) }
end


# authorize do |username, password|
#   username == 'admin' && password == 'admin'
# end


  get '/' do
    @users = UserController.show_users()
    #erb :index
  end


  get '/user/:id/get' do
    UserController.get_user(params[:id]) ? 222 : 443
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
    UserController.delete_user(params[:id]) ?  333 : 443
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

error 443 do
  "Something works wrong"
end
