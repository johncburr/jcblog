class UsersController < JcblogController
  layout "user_admin"
  before_filter :authorize, :except =>
    [:show, :new, :create, :edit, :update] if :there_b_admins?
  before_filter :find_user, :except =>
    [:index, :new, :create]

  def index
    if there_b_users?
      @users = User.all
    else
      redirect_to sign_up_path
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User Saved'
      redirect_to blogposts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = 'Changes Saved'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.delete
      flash[:success] = 'User Deleted'
      redirect_to users_path
    else
      render :show
    end
  end

  def promote
    @user.user_type = 13
    if @user.update_attribute(:user_type, @user.user_type)
      redirect_to @user
    else
      render :show
    end
  end

  def demote
    @user.user_type = 0
    if @user.update_attribute(:user_type, @user.user_type)
      redirect_to @user
    else
      render :show
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
    if @user.nil?
      flash[:error] = 'Invalid User'
      redirect_to users_path
    end
  end
end