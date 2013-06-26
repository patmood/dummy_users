class User < ActiveRecord::Base
  include BCrypt

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password_hash, :presence => true
  validates_format_of :email, :with => /^\S+@[a-zA-Z0-9\-]+\.[a-z]{2,}$/

  def self.authenticate(args)
    args[:password] = BCrypt::Password.create(args[:password])
    User.find_by_email_and_password(args[:email], args[:password])
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # def self.build
  #   @user = User.new(params[:user])
  #   @user.password = params[:password]
  #   return @user
  # end
end
