# frozen_string_literal: true

require 'sinatra'
require_relative 'user_controller'
require 'rubygems'
require_relative 'models'
require 'json'


configure :development do
  set :database, { adapter: 'postgresql', encoding: 'unicode', database: 'api_db', pool: 5, user: 'kateryna', password: '123456', host: 'localhost',  port: 5432 }
end

#DB = PG.connect({ dbname: 'api_db', host: 'db', user: 'postgres', password: 'postgres' })
# set :database, { adapter: 'mysql2',  database: 'my_db_name',  username: 'root', password: 'password2021' }


# db_config_file = File.open('config/database.yml')
# db_config = YAML.safe_load(db_config_file)

# ActiveRecord::Base.establish_connection(db_config)

# set :database, 'mysql://root:my_pass@127.0.0.1:3306/my_db_name'

ActiveRecord::Base.logger = ActiveSupport::Logger.new($stdout)
ActiveRecord::Base.logger.level = :warn

use Rack::Auth::Basic, 'Restricted Area' do |username, password|
  auth_data = Auth.all
  auth_data.any? { |data| (username == data.username) && (password == data.password) }
end

get '/users' do
  UserController.show_all
end

get '/user/:key/:value/get' do
  @user = UserController.show_user_by(params[:key], params[:value])
  return 443 if @user.nil?

  return 222, @user.to_json
end

get '/user/:id/get' do
  @user = UserController.show_user_by_id(params[:id])
  return 443 if @user.nil?

  return  222, @user.to_json
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
  return 333, @user.to_json if @user.errors.empty?

  444
end

delete '/user/:id/delete' do
  UserController.delete_user(params[:id]) ? 333 : 443
end

patch '/user/:id/edit' do
  @user = UserController.edit_user(params[:id],
    {
      fname: params[:fname],
      lname: params[:lname],
      phone: params[:phone],
      city:  params[:city],
      age:   params[:age]
    })
  return 445 if @user == ''

  return 333, @user.to_json if @user.errors.empty?

  444
end

error 444 do
  @user.errors.messages.to_s
end

error 445 do
  'Nothing to change'
end

error 443 do
  'Something works wrong'
end
