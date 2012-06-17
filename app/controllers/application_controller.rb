class ApplicationController < ActionController::Base
  protect_from_forgery


  protected
  #ADD PROTECTED METHODS BELOW
  def set_session_for_user(user)
    if user
      session[:user_id] = user.id
      session[:user_admin] =user.admin_flag
    end
  end

  def clear_session
    session[:user_id] = nil
    session[:user_admin] = nil
  end

end
