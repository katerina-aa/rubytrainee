class AuthData < ActiveRecord::Migration[6.1]
  def change
    create_table :auths do |t|
      t.string :username
      t.string :password
    end
  end
end
