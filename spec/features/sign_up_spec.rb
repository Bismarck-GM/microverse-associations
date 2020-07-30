require 'rails_helper'

RSpec.describe 'Sign Up', type: :feature  do

  let(:user) { User.create name: 'fry' }

  scenario 'Sign Up' do
    visit new_user_path

    fill_in 'user[name]', with: 'bender'

    click_button 'Signup'

    sleep(1)

    expect(page).to have_current_path(events_path)
    
  end

  scenario 'User already exists' do
    visit new_user_path

    fill_in 'user[name]', with: user.name

    click_button 'Signup'

    sleep(1)

    expect(page).to have_content('Name has already been taken')
  end

  scenario 'Username can not be blank' do
    visit new_user_path

    fill_in 'user[name]', with: ''

    click_button 'Signup'

    sleep(1)

    expect(page).to have_content("Name can't be blank")
  end
end