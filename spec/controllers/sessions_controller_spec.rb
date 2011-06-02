require 'spec_helper'

describe SessionsController do
  it { should_not respond_to(:index) }
  it { should_not respond_to(:show) }
  it { should respond_to(:new) }
  it { should respond_to(:create) }
  it { should_not respond_to(:edit) }
  it { should_not respond_to(:update) }
  it { should respond_to(:destroy) }
  
  describe "POST create" do
    before {
      @user = Factory.build(:user)
    }
    context "with valid 'Log In'" do
      before {
        User.expects(:authenticate).returns(@user)
        post :create
      }
      it { should set_session(:user_id).to(@user.id) }
    end
    context "without valid 'Log In'" do
      before {
        User.expects(:authenticate).returns(nil)
        post :create
      }
      it { should set_the_flash }
      it { should_not set_session(:user_id) }
    end
  end
  
  describe "DELETE destroy (Log Out)" do
    before {
      delete :destroy
    }
    it { should set_session(:user_id).to(nil) }
  end
end
