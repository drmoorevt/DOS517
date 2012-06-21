class ApplicationController < ActionController::Base
  layout "mainlayout"
  protect_from_forgery



  def unauthorized
    render :text => "You are not allowed to do that!!! #{flash[:notice]}"
  end


  protected
  #ADD PROTECTED METHODS BELOW

  #find posts by username or partial content and title match
  def get_posts(searchString)
    if searchString
      @posts = Post.find_by_sql("select *,(select count(id) from comments where post_id = p.id) as vote from posts p
       where content like '%#{searchString}%' or title like '%#{searchString}%'
       or exists (select username from users where username = '#{searchString}' and id = p.user_id  )
       order by vote desc, created_at desc")
    else
      @posts = Post.find_by_sql("select top 10 *,(select count(id) from comments where post_id = posts.id) as vote from posts
      order by vote desc, created_at desc")
    end

  end

  #it will be called from action filter
  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in to access this page"
      session[:return_to] =   request.fullpath
      logger.info "request refer #{request.fullpath}"
      redirect_to :controller => "auth", :action => "login"
    end
  end

  def has_admin_access
    user = User.find_by_id(session[:user_id])
    if user.nil? || user.admin_flag != true
       logger.info "User is not admin #{session[:user_id]}"
       redirect_to  "unauthorized"
    end
  end

  def set_session_for_user(user)
    if user
      session[:user_id] = user.id
      session[:user_admin] =user.admin_flag
      session[:user_name] =user.username
    end
  end

  def clear_session
    session[:user_id] = nil
    session[:user_admin] = nil
    session[:user_name] = nil
  end

end
