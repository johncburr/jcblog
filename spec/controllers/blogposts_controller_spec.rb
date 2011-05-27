require 'spec_helper'

describe BlogpostsController do
  it { should respond_to(:index) }
  it { should respond_to(:show) }
  it { should respond_to(:new) }
  it { should respond_to(:create) }
  it { should respond_to(:edit) }
  it { should respond_to(:update) }
  it { should respond_to(:destroy) }

  describe "GET 'index'" do
    before {
      @user = Factory.build(:user)
      User.expects(:find).returns(@user)
      get :index
    }
    it { should respond_with(:success) }
    it { should render_template("layouts/userplus", :index) }
    it { should assign_to(:blogposts).with(@user.blogposts) }
  end

  describe "GET 'show'" do
    before {
      @blogpost = Factory.build(:blogpost)
    }
    context "with a valid id" do
      before {
        @user = Factory.build(:user)
        User.expects(:find).returns(@user)
        Blogpost.expects(:find).returns(@blogpost)
        get :show, :id => 1
      }
      it { should respond_with(:success) }
      it { should render_template("layouts/userplus", :show) }
      it { should assign_to(:blogpost).with(@blogpost) }
    end
    context "without a valid id" do
      before {
        Blogpost.expects(:find).returns(nil)
        get :show, :id => 1
      }
      it { should redirect_to(blogposts_path) }
      it { should set_the_flash }
    end
  end

  describe "GET 'new'" do
    before {
      @user = Factory.build(:user)
      User.expects(:find).returns(@user)
      get :new
    }
    it { should respond_with(:success) }
    it { should render_template("layouts/userplus", :new) }
  end

  describe "POST 'create'" do
    before {
      @user = Factory.build(:user)
      User.expects(:find).returns(@user)
      @blogpost = Factory.build(:blogpost)
      Blogpost.expects(:new).returns(@blogpost)
    }
    context "save succeeds" do
      before {
        @blogpost.expects(:save).returns(true)
        post :create, :blogpost => @blogpost
      }
      it { should redirect_to(@blogpost) }
      it { should set_the_flash }
    end
    context "save fails" do
      before {
        @blogpost.expects(:save).returns(false)
        post :create, :blogpost => {}
      }
      it { should respond_with(:success) }
      it { should render_template("layouts/userplus", :new) }
    end
  end

  describe "GET 'edit'" do
    before {
      @blogpost = Factory.build(:blogpost)
    }
    context "with a valid id" do
      before {
        @user = Factory.build(:user)
        User.expects(:find).returns(@user)
        Blogpost.expects(:find).returns(@blogpost)
        get :edit, :id => 1
      }
      it { should respond_with(:success) }
      it { should render_template("layouts/userplus", :edit) }
      it { should assign_to(:blogpost).with(@blogpost) }
    end
    context "without a valid id" do
      before {
        Blogpost.expects(:find).returns(nil)
        get :edit, :id => 1
      }
      it { should redirect_to(blogposts_path) }
      it { should set_the_flash }
    end
  end

  describe "PUT 'update'" do
    before {
      @blogpost = Factory.build(:blogpost)
    }
    context "with a valid id" do
      before {
        Blogpost.expects(:find).returns(@blogpost)
      }
      context "update succeeds" do
        before {
          @blogpost.stubs(:update_attributes).returns(true)
          put :update, :id => 1, :blogpost => {}
        }
        it { should redirect_to(@blogpost) }
        it { should set_the_flash }
      end
      context "update fails" do
        before {
          @blogpost.stubs(:update_attributes).returns(false)
          put :update, :id => 1, :blogpost => {}
        }
        it { should render_template("layouts/userplus", :edit) }
      end
    end
    context "without a valid id" do
      before {
        Blogpost.expects(:find).returns(nil)
        put :update, :id => 1, :blogpost => {}
      }
      it { should redirect_to(blogposts_path) }
      it { should set_the_flash }
    end
  end

  describe "DELETE 'destroy'" do
    before {
      @blogpost = Factory.build(:blogpost)
    }
    context "with a valid id" do
      before {
        Blogpost.stubs(:find).returns(@blogpost)
      }
      context "delete succeeds" do
        before {
          @blogpost.expects(:delete).returns(true)
          delete :destroy, :id => 1
        }
        it { should redirect_to(blogposts_path) }
      end
      context "delete fails" do
        before {
          @blogpost.expects(:delete).returns(false)
          delete :destroy, :id => 1
        }
        it { should redirect_to(@blogpost) }
        it { should set_the_flash.to(/Failed/) }
      end
    end
    context "without a valid id" do
      before {
        Blogpost.stubs(:find).returns(nil)
        delete :destroy, :id => 1
      }
      it { should redirect_to(blogposts_path) }
      it { should set_the_flash.to(/Post/) }
    end
  end
end