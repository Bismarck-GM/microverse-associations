class User < ApplicationRecord
  has_many :events
  has_many :event_users
  has_many :appointments, :through => :event_users, :source => :attended_event
end
