require 'rails_helper'

feature 'User can add comment to question', %q{
  In order to provide additional info to question
  As an authinticated user
  I'd like to be able to add comment
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authinticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'adds comment to question' do
      within '.question-comments' do
        fill_in 'comment[body]', with: 'some comment'
        click_on 'Add Comment'
      end

      expect(page).to have_content 'some comment'
    end
  end

  scenario 'Unauthinticated user tries to add comment' do
    visit question_path(question)

    within '.question-comments' do
      expect(page).not_to have_content 'Add Comment'
    end
  end
end
