class InviteUser < ApplicationRecord
  belongs_to :invited_event, class_name: Event.name, foreign_key: 'event_id'
  belongs_to :invited_user, class_name: User.name, foreign_key: 'user_id'
end
