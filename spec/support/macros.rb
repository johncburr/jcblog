module ControllerMacros
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def it_should_require_admin_for_actions(red_loc, *actions)
      actions.each do |action|
        it "<#{action}> action should require admin" do
          get action, :id => 1
          response.should redirect_to(red_loc)
        end
      end
    end
  end

  def make_test_admin(set_email, set_pass)
    myuser = User.new(:name => "Test Name",
                    :email => set_email,
                    :password => set_pass,
                    :password_confirmation => set_pass)
    myuser.user_type = 13
    myuser.save!
  end

  def make_test_user(set_email, set_pass)
    myuser = User.new(:name => "Test Name",
                    :email => set_email,
                    :password => set_pass,
                    :password_confirmation => set_pass)
    myuser.user_type = 0
    myuser.save!
  end
end