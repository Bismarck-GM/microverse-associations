class EventUser < ApplicationRecord
  belongs_to :attended_event, class_name: Event.name, foreign_key: 'event_id'
  belongs_to :attendee, class_name: User.name, foreign_key: 'user_id'
end
