require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.describe 'Invite Event form', type: :feature do
  include AuthenticationHelper
  let!(:user) { User.create name: 'bender' }
  let(:event) { Event.create name: 'Cheese', description: 'More Cheese', location: 'Cheese', date: Date.tomorrow, user_id: user.id }

  scenario 'Does not render the form if the user is not the Author' do
    visit event_path(event.id)
    expect(page).to_not have_content('Internet explorer says hi')
  end

  scenario 'Render the form if the user is the Author' do
    login_user
    visit event_path(event.id)
    expect(page).to have_content('Internet explorer says hi')
  end

  scenario 'Return User not found' do
    login_user
    visit event_path(event.id)
    click_button 'Invite'
    expect(page).to have_content('You broke something!')
  end

  scenario 'Return User invited succesfully' do
    login_user
    visit event_path(event.id)
    fill_in 'user[name]', with: 'bender'
    click_button 'Invite'
    expect(page).to have_content('Boo')
  end

  scenario 'Return User already invited' do
    event.invited_users << user
    login_user
    visit event_path(event.id)
    fill_in 'user[name]', with: 'bender'
    click_button 'Invite'
    expect(page).to have_content('User is already invited')
  end
end
