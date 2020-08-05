require 'rails_helper'
require './spec/support/authentication_helper'

RSpec.describe 'Attend button action', type: :feature do
  include AuthenticationHelper
  let!(:user) { User.create name: 'bender' }
  let(:event) do
    Event.create({
                   name: 'Cheese',
                   description: 'More Cheese',
                   location: 'Cheese',
                   date: Date.tomorrow,
                   creator_id: user.id
                 })
  end

  scenario 'Returns error if user is not invited', js: true do
    login_user
    visit event_path(event.id)
    click_button 'Attend'
    expect(page).to have_content('You are not invited to this event.')
  end

  scenario 'Returns Success if user is able to attend', js: true do
    event.invited_users << user
    login_user
    visit event_path(event.id)
    click_button 'Attend'
    expect(page).to have_content('Attend succesfully commited')
  end
end
