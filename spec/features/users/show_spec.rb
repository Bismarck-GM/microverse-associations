require 'rails_helper'

RSpec.describe 'Show Users', type: :feature do
  let!(:user) { User.create name: 'bender' }

  scenario 'Show User must display user name' do
    visit user_path(user.id)
    expect(page).to have_content(user.name)
  end

  scenario 'Show User must display Future Users events and invited events' do
    event = Event.create({
                           name: 'Cheese',
                           description: 'More Cheese',
                           location: 'Cheese',
                           date: Date.tomorrow,
                           creator_id: user.id
                         })
    event.attendees << user
    visit user_path(user.id)
    expect(page).to have_content(event.name)
  end

  scenario 'Show User must display Past Users events and attended events' do
    event = Event.new({
                        name: 'Cheese',
                        description: 'More Cheese',
                        location: 'Cheese',
                        date: Date.yesterday,
                        creator_id: user.id
                      })
    event.save(validate: false)
    event.attendees << user
    visit user_path(user.id)
    expect(page).to have_content(event.name)
  end
end
