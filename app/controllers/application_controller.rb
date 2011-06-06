class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?
  helper_method :authorize
  helper_method :current_user
  helper_method :there_b_admins?
  helper_method :there_b_users?

  private

  def admin?
    current_user.user_type == 13 if current_user
  end

  def authorize
    if there_b_admins? && !admin?
      redirect_to root_url
    end
  end

  def there_b_admins?
    !User.find_by_user_type(13).nil?
  end

  def there_b_users?
    User.count != 0
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
