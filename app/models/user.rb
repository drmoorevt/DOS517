class User < ActiveRecord::Base
  attr_accessible :admin_flag, :description, :email, :first_name, :last_name, :password, :username ,:password_confirmation

  validates :username,  :presence => true  , :uniqueness => true
  validates :email,  :presence => true  ,:uniqueness => true  ,:format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                                                                            :message => "Email is not valid!" }
  validates :password,  :presence => true ,:confirmation => true,:on => :create #add password_confirmation #validate for create action
  validates :first_name,  :presence => true
  validates :last_name,  :presence => true

  has_many :posts


  before_create :hashpassword
  OURSECRECTTOKEN = "dfgdfghoi3h45hgdlfghl4e3434g34g34"

  def has_same_password(checkpass)
    return self.password ==  Digest::MD5.hexdigest("-#{checkpass}#{OURSECRECTTOKEN}")
  end

  #find user by name or email and then check password .
  #Class method
  def self.authenticate(username_or_email,pass)
    @user = User.find_by_username( username_or_email)
    if @user.nil?
      @user = User.find_by_email(username_or_email)
    end

    #if we got user, we need to check password
    if @user.nil?
      return false
    end
    #check if password is right
    if @user.has_same_password(pass)
      return @user
    end
    return false
  end

  protected
  def hashpassword
    self.password = Digest::MD5.hexdigest("-#{self.password}#{OURSECRECTTOKEN}")
  end
end
