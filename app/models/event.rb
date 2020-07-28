class Event < ApplicationRecord
  belongs_to :creator, class_name: User.name, foreign_key: 'user_id'
  has_many :event_users
  has_many :attendees, :through => :event_users, :source => :attendee

  scope :past, -> { where("date < ?", Time.now) }
  scope :upcoming, -> { where("date > ?", Time.now) }

end
