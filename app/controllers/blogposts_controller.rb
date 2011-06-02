class BlogpostsController < ApplicationController
  before_filter :authorize, :except => [:index, :show ]

  def index
    @blogposts = Blogpost.all
  end

  def show
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.nil?
      redirect_to blogposts_path
      flash[:error] = "Invalid Post"
    else
      @user = @blogpost.user
    end
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
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.nil?
      redirect_to blogposts_path
      flash[:error] = "Invalid Post"
    else
      @user = @blogpost.user
    end
  end

  def update
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.nil?
      redirect_to blogposts_path
      flash[:error] = "Changes Not Saved"
    else
      if @blogpost.update_attributes(params[:blogpost])
        redirect_to @blogpost
        flash[:success] = "Changes Saved"
      else
        render :edit
      end
    end
  end

  def destroy
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.nil?
      redirect_to blogposts_path
      flash[:error] = "Post Not Found"
    else
      if @blogpost.delete
        redirect_to blogposts_path
      else
        redirect_to @blogpost
        flash[:error] = "Delete Failed"
      end
    end
  end
end