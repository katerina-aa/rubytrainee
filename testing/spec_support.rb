require_relative 'data_generator'
require_relative '../api/user_controller'
require_relative 'invalid_data'
require_relative 'id_generator'

ActiveRecord::Base.establish_connection(
    adapter:  "sqlite3",
    database: "../api/development.sqlite3"
)
