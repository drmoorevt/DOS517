class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :title
      t.integer :user_id
      t.integer :vote

      t.timestamps
    end
  end
end
