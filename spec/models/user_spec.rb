require 'spec_helper'

describe User do
  it { should have_many(:blogposts) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(48).with_short_message(/48 characters or less/) }
  it { should validate_presence_of(:email) }
  it { should validate_format_of(:email).with(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) }
  it { should validate_presence_of(:password) }
  it { should_not be_valid }
  describe "authenticate" do
    before(:all) {
      @set_pass = "testpass"
      @set_email = "testemail@example.com"
      make_test_admin(@set_email, @set_pass)
      @user = User.find_by_email(@set_email)
    }
    it "should succeed with valid credentials" do
      User.authenticate(@set_email, @set_pass).should == @user
    end
    it "should fail with invalid credentials" do
      new_pass = @set_pass + "not"
      User.authenticate(@set_email, new_pass).should == nil
    end
    it "should fail with invalid email" do
      User.authenticate("invalid", @set_pass).should == nil
    end
    after(:all) {
      User.delete(@user.id)
    }
  end
end