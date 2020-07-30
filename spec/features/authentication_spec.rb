require 'rails_helper'

RSpec.describe 'Authentication', type: :feature  do
  let(:user) { User.create name: 'bender' }

  scenario 'login' do
    visit new_session_path

    fill_in 'user[name]', with: user.name

    click_button 'Login'

    sleep(1)

    expect(page).to have_content('Create a new event')
    
  end

  scenario 'logout', js: true do

    visit new_session_path

    fill_in 'user[name]', with: user.name

    click_button 'Login'

    sleep(1)

    click_button 'logout'

    sleep(1)

    expect(page).to have_current_path(new_session_path)

  end

end