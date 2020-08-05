require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.describe 'Show Event Details', type: :feature do
  include AuthenticationHelper
  let(:user) { User.create name: 'bender' }

  scenario 'Does not allow unauthenticated users to show the details of an event' do
    visit events_path
    click_button 'Create'
    expect(page).to have_current_path(new_session_path)
  end

  scenario 'Shows validation errors' do
    login_user
    visit events_path
    click_button 'Create'

    expect(page).to have_content('What did you do!')
  end

  scenario 'Creates event' do
    login_user
    visit events_path

    fill_in 'event[name]', with: 'bender'
    fill_in 'event[date]', with: Date.tomorrow
    fill_in 'event[location]', with: 'the moon'
    fill_in 'event[description]', with: 'lorem ipsum dolor sit amet'
    click_button 'Create'
    expect(page).to have_content('Event created successfully')
  end
end
