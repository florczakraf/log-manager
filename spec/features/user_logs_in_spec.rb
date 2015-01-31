require 'rails_helper'

feature 'User logs in' do
  scenario 'with valid email and password' do
    sign_up_with 'testuser', 'valid@example.com', 'password'
    log_in
    expect(page).to have_content("Welcome testuser")
  end
  
  scenario 'with valid email and password' do
    log_in
    expect(page).to have_content("Invalid Username or Password")
  end
  
  def sign_up_with(username, email, password, password2 = password)
    visit new_user_path
    fill_in 'user_username', with: username
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password2
    click_button 'Sign up'
  end
  
  def log_in
      visit login_path
      fill_in 'username_or_email', with: 'testuser'
      fill_in 'login_password', with: 'password'
      click_button 'Log In'
    end
end