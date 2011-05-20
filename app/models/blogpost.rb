# == Schema Information
# Schema version: 20110519140647
#
# Table name: blogps
#
#  id         :integer         not null, primary key
#  entry_text :string(255)
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Blogpost < ActiveRecord::Base
  validates_presence_of :title, :entry_text, :user_id
  validates_length_of :entry_text, :maximum => 255
end
