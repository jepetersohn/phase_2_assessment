class Event < ActiveRecord::Base
  has_many :users, :through => :event_user

end
