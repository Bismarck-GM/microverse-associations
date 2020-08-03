require 'rails_helper'

RSpec.describe EventUser, type: :model do
  describe 'associations' do
    it { should belong_to(:attended_event).class_name(Event.name).with_foreign_key(:event_id) }
    it { should belong_to(:attendee).class_name(User.name).with_foreign_key(:user_id) }
  end
end
