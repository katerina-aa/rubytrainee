require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models'


set :database, { adapter: 'sqlite3', database: 'development.sqlite3' }

get '/' do
  @users = User.all
  erb :index
end

post '/' do
  User.create({ fname: params[:fname], lname: params[:lname] })
  redirect to '/'
end

delete '/user/:id/delete' do
  @user = User.find_by(id: params[:id])
  @user.destroy
  redirect to '/'
end

patch '/user/:id/edit' do 
  @user = User.find_by_id(params[:id])
  @user.fname = params[:fname]
  @user.lname = params[:lname]
  @user.save
  redirect to "/"
end