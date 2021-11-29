# frozen_string_literal: true

# The class AuthData is responsible for creating the table structure
class AuthData < ActiveRecord::Migration[6.1]
  def change
    create_table :auths do |t|
      t.string :username
      t.string :password
    end
  end
end
