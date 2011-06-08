# == Schema Information
# Schema version: 20110520173756
#
# Table name: blogposts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  entry_text :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Blogpost < ActiveRecord::Base
  belongs_to :user
  validates :title, :presence => true, :length => {:maximum => 255}
  validates :entry_text, :presence => true
  validates :user_id, :presence => true
end
