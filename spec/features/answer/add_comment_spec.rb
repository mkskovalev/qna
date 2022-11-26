require 'rails_helper'

feature 'User can add comment to answer', %q{
  In order to provide additional info to answer
  As an authinticated user
  I'd like to be able to add comment
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question_id: question.id) }

  describe 'Authinticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'adds comment to answer' do
      within '.answer-comments' do
        fill_in 'comment[body]', with: 'some answer comment'
        click_on 'Add Comment'
      end

      expect(page).to have_content 'some answer comment'
    end
  end

  scenario 'Unauthinticated user tries to add comment' do
    visit question_path(question)

    within '.answer-comments' do
      expect(page).not_to have_content 'Add Comment'
    end
  end
end
