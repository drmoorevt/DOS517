
class UsersController < ApplicationController
  #filter action request for ADMIN login to specific methods
  #Admin can create users from this screen
  before_filter :has_admin_access , :only => [:index ]
  #filter action request for login
  before_filter :authorize , :except => [:login,:login_post,:new,:create]


  # Only admin can list all users
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    secure_user_access
  end

  def secure_user_access
    if !session[:user_admin]
      #not admin so check if userid is same as this object user is editing
      #if not redirect to unauth
      if @user.id != session[:user_id]
        flash[:notice] = "Not admin and not same user"
        redirect_to :action => "unauthorized"
      end
    end
  end

  # POST /users
  # POST /users.json
  def create


    @user = User.new(params[:user])



    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    secure_user_access
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    secure_user_access
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
