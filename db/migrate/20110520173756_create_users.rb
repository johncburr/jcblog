class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :email, :pepper, :salt
      t.integer :user_type
      t.timestamps
    end
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
