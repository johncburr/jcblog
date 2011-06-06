class BlogpostsController < ApplicationController
  before_filter :authorize, :except => [:index, :show ]
  before_filter :find_blogpost, :except => [:index, :new, :create]

  def index
    @blogposts = Blogpost.all
  end

  def show
    @user = @blogpost.user
  end

  def new
    @user = User.find(session[:user_id])
    @blogpost = @user.blogposts.new
  end

  def create
    @user = User.find(session[:user_id])
    @blogpost = @user.blogposts.new(params[:blogpost])
    if @blogpost.save
      flash[:success] = "Post Saved"
      redirect_to @blogpost
    else
      render :new
    end
  end

  def edit
    @user = @blogpost.user
  end

  def update
    if @blogpost.update_attributes(params[:blogpost])
      flash[:success] = "Changes Saved"
      redirect_to @blogpost
    else
      render :edit
    end
  end

  def destroy
    if @blogpost.delete
      redirect_to blogposts_path
    else
      flash[:error] = "Delete Failed"
      redirect_to @blogpost
    end
  end

  private

  def find_blogpost
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.nil?
      flash[:error] = "Invalid Post"
      redirect_to blogposts_path
    end
  end
end