class BlogpostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @blogposts = @user.blogposts
  end

  def show
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.nil?
      redirect_to blogposts_path
      flash[:error] = "Invalid Post"
    end
  end

  def new
    @blogpost = Blogpost.new(:user_id => params[:uid])
  end

  def create
    @blogpost = Blogpost.new(params[:blogpost])
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
        flash[:error] = "Save Failed"
      end
    end
  end
end