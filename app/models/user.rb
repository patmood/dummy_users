class User < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates_format_of :email, :with => /^\S+@[a-zA-Z0-9\-]+\.[a-z]{2,}$/

  def self.authenticate(args)
    User.find_by_email_and_password(args[:email], args[:password])
  end
end
