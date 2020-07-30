module AuthenticationHelper
  def login_user
    User.create name: 'bender'
    visit new_session_path
    fill_in 'user[name]', with: user.name
    click_button 'Login'
  end
end
