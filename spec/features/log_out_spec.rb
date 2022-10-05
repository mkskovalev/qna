require 'rails_helper'

feature 'User can log out', %q{
  In order to end session
  As an authinticated user
  I'd like to be able to log out
} do

  given(:user) { create(:user) }

  scenario 'Registered user tries to log out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'

    click_on 'Log Out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
