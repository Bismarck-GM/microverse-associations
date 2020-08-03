require 'rails_helper'

RSpec.describe 'Index Events', type: :feature do
  let(:user) { User.create name: 'bender' }
  let(:event) { { name: 'name', location: 'foobar', date: Date.tomorrow, description: 'lorem' } }

  scenario 'Shows upcoming events.' do
    user.events.create(event.merge(name: 'today', date: 1.minute.from_now))
    user.events.create(event.merge(name: 'tomorrow', date: Date.tomorrow))
    visit events_path
    sleep(1)
    expect(page).to have_content('today')
    expect(page).to have_content('tomorrow')
  end

  scenario 'Shows upcoming events.' do
    user.events.build(event.merge(name: 'yesterday', date: 1.day.ago)).save(validate: false)
    visit events_path
    sleep(1)
    expect(page).to have_content('yesterday')
  end
end
