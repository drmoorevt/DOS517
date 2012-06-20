class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  #populate from query
  attr_accessible :vote
  belongs_to :user
  #delete related comments if we delete this post
  has_many :comments  , :dependent => :destroy

  validates :content,  :presence => true, :length => { :maximum => 140 }
  validates :title,  :presence => true ,:length => { :maximum => 50 }
  validates :user_id,  :presence => true

  def self.search(query)
    if params[:query]
      @posts = Post.search(params[:query])
    else
      @posts = []
    end
    respond_to do |format|
      format.html # search_posts.html.erb
      format.json { render json: @post }
    end
  end
end
