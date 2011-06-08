class JcblogConfig < ActiveRecord::Migration
  def self.up
    create_table "blogposts" do |t|
      t.string   "title"
      t.text     "entry_text"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "blogposts", ["user_id"], :name => "index_blogposts_on_user_id"

    create_table "users" do |t|
      t.string   "name"
      t.string   "email"
      t.string   "pepper"
      t.string   "salt"
      t.integer  "user_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "users", ["email"], :name => "index_users_on_email"
  end

  def self.down
    drop_table :blogposts
    drop_table :users
  end
end
