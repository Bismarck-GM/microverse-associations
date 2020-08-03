require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:creator).class_name(User.name).with_foreign_key(:user_id) }
    it { should have_many(:event_users) }
    it { should have_many(:attendees).through(:event_users).source(:attendee) }
    it { should have_many(:invite_users) }
    it { should have_many(:invited_users).through(:invite_users).source(:invited_user) }
  end

  describe 'validations' do
    subject do
      Event.create({
                     name: 'A random user',
                     location: 'foobar',
                     description: 'lorem ipsum dolor sit amet',
                     date: Date.tomorrow,
                     user_id: 1
                   })
    end

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(255) }
    it { should validate_presence_of(:location) }
    it { should validate_length_of(:location).is_at_least(3).is_at_most(255) }
    it { should validate_length_of(:description).is_at_least(3) }
    it { should validate_presence_of(:date) }
  end
end
