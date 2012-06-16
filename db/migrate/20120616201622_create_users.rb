class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.text :description
      t.boolean :admin_flag

      t.timestamps
    end
  end
end
