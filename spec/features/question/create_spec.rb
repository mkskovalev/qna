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
      within '.question' do
        fill_in 'Title', with: 'Some question'
        fill_in 'Body', with: 'Some text'
      end

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
      within '.question' do
        fill_in 'Title', with: 'Some question'
        fill_in 'Body', with: 'Some text'
      end

      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthinticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask Question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  describe 'multiple sessions', js: true do
    scenario "question appears on another user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end

      Capybara.using_session('quest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on 'Ask Question'

        within '.question' do
          fill_in 'Title', with: 'Some question'
          fill_in 'Body', with: 'Some text'
        end

        click_on 'Ask'

        expect(page).to have_content 'Some question'
        expect(page).to have_content 'Some text'
      end

      Capybara.using_session('quest') do
        expect(page).to have_content 'Some question'
      end
    end
  end

end
