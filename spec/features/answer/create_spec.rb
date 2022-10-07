require 'rails_helper'

feature 'User can create answer on question page', %q{
  In order to help the user solve his problem
  As an authinticated user
  I'd like to be able to add answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  describe 'Authinticated user' do
    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'add answer', js:true do
      fill_in 'answer[body]', with: 'Some Body'
      click_on 'Add Answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'Some Body'
      end
    end

    scenario 'add answer with errors', js:true do
      click_on 'Add Answer'

      within '.answer-errors' do
        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  scenario 'Unauthinticated user tries to create answer' do
    visit question_path(question)
    click_on 'Add Answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
