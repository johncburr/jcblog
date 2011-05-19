require 'spec_helper'

describe Blogp do
  before(:each) do
    @attr = {:entry_text => " ",
            :user_id => nil}
    @blog_post = Blogp.create!(@attr)
  end

  describe ":new" do
    it "should require a valid entry (non-empty)" do
      @blog_post[:entry_text].should_not be_empty
    end

    it "should store a user_id"
  end
end
