class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :vote  ,:post_id   ,:author
  belongs_to :post
end
