class User < ActiveRecord::Base
  attr_accessible :admin_flag, :description, :email, :first_name, :last_name, :password, :username

  validates :username,  :presence => true
  validates :email,  :presence => true
  validates :password,  :presence => true ,:confirmation => true,:on => :create #add password_confirmation #validate for create action

  before_create :hashpassword
  OURSECRECTTOKEN = "dfgdfghoi3h45hgdlfghl4e3434g34g34"

  def has_same_password(checkpass)
    return self.password ==  Digest::MD5.hexdigest("-#{checkpass}#{OURSECRECTTOKEN}")
  end
  protected
  def hashpassword
    password = Digest::MD5.hexdigest("-#{checkpass}#{OURSECRECTTOKEN}")
  end
end
