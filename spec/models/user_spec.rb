require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:events).with_foreign_key(:creator_id) }
    it { should have_many(:event_users) }
    it { should have_many(:invite_users) }
    it { should have_many(:appointments).through(:event_users).source(:attended_event) }
    it { should have_many(:invites).through(:invite_users).source(:invited_event) }
  end

  describe 'validations' do
    subject { User.create(name: 'A random user') }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(255) }
  end
end
