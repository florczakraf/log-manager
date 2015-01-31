require 'rails_helper'

feature 'User signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'testuser', 'valid@example.com', 'password'

    expect(page).to have_content('You signed up successfully')
  end

  scenario 'with invalid email' do
    sign_up_with 'testuser', 'invalid_email', 'password'

    expect(page).to have_content('Form is invalid')
  end

  scenario 'with blank password' do
    sign_up_with 'testuser', 'valid@example.com', ''

    expect(page).to have_content('Form is invalid')
  end
  
  scenario 'with blank username' do
    sign_up_with '', 'valid@example.com', 'password'

    expect(page).to have_content('Form is invalid')
  end
  
  scenario 'with bad password confirmation' do
    sign_up_with 'username', 'valid@example.com', 'password', 'password2'

    expect(page).to have_content('Form is invalid')
  end
  
  scenario 'with bad password confirmation' do
    sign_up_with 'username', 'valid@example.com', 'password', 'password2'

    expect(page).to have_content('Form is invalid')
  end

  def sign_up_with(username, email, password, password2 = password)
    visit new_user_path
    fill_in 'user_username', with: username
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password2
    click_button 'Sign up'
  end
end