require_relative 'data_generator'
require_relative '../api/user_controller'


ActiveRecord::Base.establish_connection(
    adapter:  "sqlite3",
    database: "../api/development.sqlite3"
)
