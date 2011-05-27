class UsersController < ApplicationController
  def index
    @users = User.all
    session[:show_user_id] = ""
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to users_path
      flash[:error] = 'Invalid User'
    else
      session[:show_user_id] = @user.id
      render :layout => "userplus", :template => "users/show"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
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
