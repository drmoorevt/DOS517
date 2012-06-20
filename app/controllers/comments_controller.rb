
class CommentsController < ApplicationController
  #Admin can see list of comments, delete comments
  before_filter :has_admin_access , :only => [:index,:destroy ]







  # GET /comments/show_for_post/postid
  def show_for_post
    @post = Post.find(params[:id])
    postid = -1
    if @post
      postid = @post.id
    end

         #GET comments for this post
      @comments = Comment.find_all_by_post_id(postid)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @comments }
      end





  end




  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end


  #get post info and create comment for that
  # POST /comments
  # POST /comments.json
  def create

    @post = Post.find(params[:post_id])
    @comment = Comment.new


    @comment.content =  params[:content]
    @comment.post_id = params[:post_id]
    @comment.author = params[:author]
    #add userid to comment if logged in
    if session[:user_id]
      @comment.user_id = session[:user_id]
      anyuser = User.find(session[:user_id])
      if anyuser
        @comment.author = anyuser.username
      else
        @comment.author = "Nobody!!!"
      end
    end
   if @comment.save
     flash[:notice] = "SAVED...."
   else
      flash[:notice] = "NOT SAVED !!!"
   end

    redirect_to @post


   end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
