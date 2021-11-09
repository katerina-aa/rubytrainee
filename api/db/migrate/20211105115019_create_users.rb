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
