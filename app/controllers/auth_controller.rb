
class AuthController < ApplicationController

  def login

  end

  def login_post


    if request.post?
      user = User.authenticate(params[:username_or_email],params[:password])
      if user
          #record into session
        logger.info "user logins #{params[:username_or_email]} return to #{session[:return_to]}"
        set_session_for_user(user)
        if session[:return_to].nil?
          redirect_to :action => "index"
        else
          redirectpath = session[:return_to]
          session[:return_to] = nil
          redirect_to redirectpath
        end

      else
        redirect_to "login", :notice => 'Oops! Your password is not right!'
      end
    end

  end

  def logout
    clear_session
    flash[:notice] ="You are logged out!"
    redirect_to :action => "login"
  end

  def index
    #auth access page
    logger.info "Accessing user sessionid #{session[:user_id]}"
    @hasadmin = session[:user_admin] == true
  end
end
