class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :post_id, :author
  validates :author,  :presence => true
  validates :post_id,  :presence => true

  belongs_to :post
end
