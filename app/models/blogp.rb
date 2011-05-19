# == Schema Information
# Schema version: 20110519140647
#
# Table name: blogps
#
#  id         :integer         not null, primary key
#  entry_text :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Blogp < ActiveRecord::Base
  attr_accessible :entry_text, :user_id

#  validates :entry_text,    :presence   =>  true
#  validates :user_id,       :presence   =>  true

end
