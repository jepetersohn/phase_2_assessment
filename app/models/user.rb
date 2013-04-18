require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :events, :through => :event_user

  validates :email, :password, :presence => true
  validates :email, :uniqueness => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def created_events
    Event.where(:user_id => self.id)
  end

  def attended_events
    
  end

end
