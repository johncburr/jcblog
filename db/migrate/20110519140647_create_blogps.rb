class CreateBlogps < ActiveRecord::Migration
  def self.up
    create_table :blogps do |t|
      t.string  :entry_text
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :blogps
  end
end
