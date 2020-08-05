require 'rails_helper'

RSpec.describe InviteUser, type: :model do
  describe 'associations' do
    it { should belong_to(:invited_event).class_name(Event.name).with_foreign_key(:event_id) }
    it { should belong_to(:invited_user).class_name(User.name).with_foreign_key(:user_id) }
  end
end
