class CreateUsers < ActiveRecord::Migration
 def self.up
   create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :uid
      t.string :provider

      t.timestamps null: false
   end
 end

 def self.down
   drop_table :users
 end
end
