class User < ApplicationRecord
  has_many :events
  has_many :event_users
  has_many :invite_users
  has_many :appointments, :through => :event_users, :source => :attended_event
  has_many :invites, :through => :invite_users, :source => :invited_event

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }, uniqueness: true
end
