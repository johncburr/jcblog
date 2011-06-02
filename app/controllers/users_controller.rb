class UsersController < ApplicationController
  layout "user_admin"
  before_filter :authorize if User.all.length > 0

  def index
    @users = User.all
    if @users == []
      redirect_to sign_up_path
      flash[:error] = 'There are no users'
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to users_path
      flash[:error] = 'Invalid User'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to blogposts_path
      flash[:success] = 'User Saved'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to users_path
      flash[:error] = 'Invalid User'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to users_path
      flash[:error] = 'Invalid User'
    else
      if @user.update_attributes(params[:user])
        redirect_to @user
        flash[:success] = 'Changes Saved'
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to users_path
      flash[:error] = 'Invalid User'
    else
      if @user.delete
        redirect_to users_path
        flash[:success] = 'User Deleted'
      else
        render :show
      end
    end
  end
end
