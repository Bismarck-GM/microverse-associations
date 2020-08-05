require 'rails_helper'

RSpec.describe 'Index users', type: :feature do
  let!(:user) { User.create name: 'bender' }

  scenario 'Users Index should contain title' do
    visit users_path
    expect(page).to have_content('All the spies')
  end

  scenario 'Display a list of users' do
    visit users_path
    expect(page).to have_content('bender')
  end
end
