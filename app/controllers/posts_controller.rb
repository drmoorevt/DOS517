
class PostsController < ApplicationController

  before_filter :authorize , :only => [:new,:edit,:create,:update,:destroy]

  # GET /posts
  # GET /posts.json
  def index
    get_posts("")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end


  # POST /search_posts
  # POST /search_posts/json
  def search_posts
    get_posts(params[:search_str])

    respond_to do |format|
      format.html  # search...
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    postid = -1
    if @post
      postid = @post.id
    end

    #GET comments for this post
    @comments = Comment.find_all_by_post_id(postid)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = session[:user_id]

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.user_id == session[:user_id]
      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end

    else
      #show unauth
      logger.warn "Unauthorized access!"
      redirect_to :action =>  "unauthorized"
    end


  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if @post.user.id == session[:user_id] or session[:user_admin] == true
      @post.destroy

      respond_to do |format|
        format.html { redirect_to posts_url }
        format.json { head :no_content }
      end
    else
      logger.warn "Unauthorized access!"
      redirect_to "unauthorized"
    end
  end
end
