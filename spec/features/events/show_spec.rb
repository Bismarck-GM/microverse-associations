require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.describe 'Show events', type: :feature do
  include AuthenticationHelper
  let!(:user) { User.create name: 'bender' }
  let(:event) do
    Event.create({
                   name: 'Cheese',
                   description: 'More Cheese',
                   location: 'Cheese',
                   date: Date.tomorrow,
                   user_id: user.id
                 })
  end

  scenario 'Does not allow unauthenticated users to access to individual events' do
    visit event_path(event.id)
    expect(page).to have_current_path(new_session_path)
  end

  scenario 'Should contain details about the event and its attendees' do
    event.attendees << user
    login_user
    visit event_path(event.id)
    expect(page).to have_content(user.name)
    expect(page).to have_content(event.location)
    expect(page).to have_content(event.description)
    expect(page).to have_content(event.date.strftime('%d %B %Y'))
    expect(page).to have_content(event.name)
  end
end
