require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from community
  As an authinticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }

  describe 'Authinticated user' do

    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask Question'
    end

    scenario 'ask a question' do
      fill_in 'Title', with: 'Some question'
      fill_in 'Body', with: 'Some text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Some question'
      expect(page).to have_content 'Some text'
    end

    scenario 'ask a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'ask a question with attached files' do
      fill_in 'Title', with: 'Some question'
      fill_in 'Body', with: 'Some text'

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"

      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
    end
  end

  scenario 'Unauthinticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask Question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
