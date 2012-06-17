class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  belongs_to :user
  #delete related comments if we delete this post
  has_many :comments  , :dependent => :destroy

  validates :content,  :presence => true, :length => { :maximum => 140 }
  validates :title,  :presence => true ,:length => { :maximum => 50 }
  validates :user_id,  :presence => true

end
