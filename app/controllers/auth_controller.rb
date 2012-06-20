
class AuthController < ApplicationController

  #filter action request for login will only prevent access to index page.
  before_filter :authorize , :only => [:index]

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
        flash[:notice] = 'Oops! Your password is not right!'
        redirect_to :action => "login"
      end
    end

  end
  #redirect to login with message
  #clear session info
  def logout
    clear_session
    flash[:notice] ="You are logged out!"
    redirect_to :action => "login"
  end




  def index
    #authorized access page
    logger.info "Accessing user sessionid #{session[:user_id]}"
    @hasadmin = session[:user_admin] == true
    get_posts("")

  end





end
