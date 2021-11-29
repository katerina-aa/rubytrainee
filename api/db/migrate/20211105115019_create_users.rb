# frozen_string_literal: true

# The class CreateUsers is responsible for creating the table structure
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :phone
      t.string :city
      t.string :age
    end
  end
end
