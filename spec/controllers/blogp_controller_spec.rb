require 'spec_helper'

describe BlogpController do
  before(:each) do
    @attr = {:entry_text => "Some test text.",
            :user_id => 1}
    @blog_post = Blogp.create!(@attr)
  end

  describe "POST :create" do
    it "should create a new post when given valid data" do
      @blog_post.should_not be_nil
    end
end