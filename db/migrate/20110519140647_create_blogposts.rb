class CreateBlogposts < ActiveRecord::Migration
  def self.up
    create_table :blogposts do |t|
      t.string  :entry_text, :title
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :blogposts
  end
end