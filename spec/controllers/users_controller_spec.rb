require 'spec_helper'

describe UsersController do
  it { should respond_to(:index) }
  it { should respond_to(:show) }
  it { should respond_to(:new) }
  it { should respond_to(:create) }
  it { should respond_to(:edit) }
  it { should respond_to(:update) }
  it { should respond_to(:destroy) }

  describe "before filter" do
    context "-- when there are admins" do
      before {
        @user = mock("user")
        User.expects(:find_by_user_type).returns(@user)
      }
      it_should_require_admin_for_actions "/", :index, :destroy, :promote, :demote
    end
  end

  describe "GET 'index'" do
    context "when users exist" do
      before {
        User.expects(:count).returns(1)
        @users = mock('Users')
        User.expects(:all).returns(@users)
        get :index
      }
      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should assign_to(:users).with(@users) }
    end
    context "when there are no users" do
      before {
        User.expects(:count).returns(0)
        get :index
      }
      it { should redirect_to(sign_up_path) }
    end
  end

  describe "GET 'show'" do
    before {
      @user = Factory.build(:user)
    }
    context "with valid id" do
      before {
        User.expects(:find).returns(@user)
        get :show, :id => 1
      }
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should assign_to(:user).with(@user) }
    end
    context "without valid id" do
      before {
        User.expects(:find).returns(nil)
        get :show, :id => 1
      }
      it { should redirect_to(users_path) }
      it { should set_the_flash }
    end
  end

  describe "GET 'new'" do
    before {
      @user = mock('User')
      User.expects(:new).returns(@user)
      get :new
    }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should assign_to(:user).with(@user) }
  end

  describe "POST 'create'" do
    before {
      @user = Factory.build(:user)
      User.expects(:new).returns(@user)
    }
    context "save succeeded" do
      before {
        @user.expects(:save).returns(true)
        post :create, :id => 1
      }
      it { should set_session(:user_id).to(@user.id) }
      it { should redirect_to(blogposts_path) }
      it { should set_the_flash }
    end
    context "save failed" do
      before {
        @user.expects(:save).returns(false)
        post :create, :id => 1
      }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end

  describe "GET 'edit'" do
    before {
      @user = mock('User')
    }
    context "with valid id" do
      before {
        User.expects(:find).returns(@user)
        get :edit, :id => 1
      }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
      it { should assign_to(:user).with(@user) }
    end
    context "without valid id" do
      before {
        User.expects(:find).returns(nil)
        get :edit, :id => 1
      }
      it { should redirect_to(users_path) }
      it { should set_the_flash }
    end
  end

  describe "PUT 'update'" do
    before {
      @user = Factory.build(:user)
    }
    context "with valid id" do
      before {
        User.expects(:find).returns(@user)
      }
      context "update_attributes succeeded" do
        before {
          @user.expects(:update_attributes).returns(true)
          put :update, :id => 1, :user => {}
        }
        it { should redirect_to(@user) }
        it { should set_the_flash }
      end
      context "update_attributes failed" do
        before {
          @user.expects(:update_attributes).returns(false)
          put :update, :id => 1, :user => {}
        }
        it { should render_template(:edit) }
        it { should assign_to(:user).with(@user) }
      end
    end
    context "without valid id" do
      before {
        User.expects(:find).returns(nil)
        put :update, :id => 1, :user => {}
      }
      it { should redirect_to(users_path) }
      it { should set_the_flash }
    end
  end

  describe "DELETE 'destroy'" do
    before {
      @user = Factory.build(:user)
    }
    context "with valid id" do
      before {
        User.expects(:find).returns(@user)
      }
      context "delete succeeded" do
        before {
          @user.expects(:delete).returns(true)
          delete :destroy, :id => 1
        }
        it { should redirect_to(users_path) }
        it { should set_the_flash.to(/Deleted/) }
      end
      context "delete failed" do
        before {
          @user.expects(:delete).returns(false)
          delete :destroy, :id => 1
        }
        it { should render_template(:show) }
        it { should assign_to(:user).with(@user) }
      end
    end
    context "without valid id" do
      before {
        User.expects(:find).returns(nil)
        delete :destroy, :id => 1
      }
      it { should redirect_to(users_path) }
      it { should set_the_flash.to(/Invalid/) }
    end
  end

  #~ describe "promote" do
    #~ context "with valid id" do
      #~ before {
        #~ @user = Factory.build(:user)
        #~ @user.user_type = 7
        #~ User.expects(:find).returns(@user)
        #~ put :promote, :id => 1
      #~ }
      #~ context "update succeeded" do
        #~ before {
          #~ @user.expects(:update_params).returns(true)
        #~ }
        #~ it "should assign 13 to user_type" do
          #~ @user.user_type.should == 13
        #~ end
        #~ it { should redirect_to(@user) }
      #~ end
      #~ context "update failed" do
        #~ before {
          #~ @user.expects(:update_params).returns(false)
        #~ }
        #~ it { should render_template(:show) }
      #~ end
    #~ end
    #~ context "without valid id"
      #~ before {
        #~ User.expects(:find).returns(nil)
        #~ put :promote, :id => 1
      #~ }
      #~ it { should set_the_flash }
      #~ it { should redirect_to(:users) }
  #~ end

  describe "demote" do
    context "with valid id" do
      before {
        @user = Factory.build(:user)
        @user.user_type = 7
        User.expects(:find).returns(@user)
      }
      context "update succeeded" do
        before {
          @user.expects(:update_params).returns(true)
          put :demote, :id => 1
        }
        it "should assign 0 to user_type" do
          @user.user_type.should == 0
        end
        it { should redirect_to(@user) }
      end
      context "update failed" do
        before {
          @user.expects(:update_params).returns(false)
          put :demote, :id => 1
        }
        it { should render_template(:show) }
      end
    end
    context "without valid id" do
      before {
        User.expects(:find).returns(nil)
        put :promote, :id => 1
      }
      it { should set_the_flash }
      it { should redirect_to(:users) }
    end
  end
end