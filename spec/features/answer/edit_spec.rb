require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do



  scenario "Unauthinticated user can't edit answer" do
    question = create(:question)
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_content 'Edit'
    end
  end

  describe 'Authinticated user' do
    given!(:user) { create(:user) }
    given!(:question) { create(:question) }
    given!(:answer) { create(:answer, question: question, user_id: user.id) }

    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'edit his answer', js: true do
      within '.answers' do
        click_on('Edit')
        fill_in 'Body', with: 'edited answer'
        click_on('Save')

        expect(page).not_to have_content answer.body
        expect(page).to have_content 'edited answer'
        # expect(page).not_to have_selector 'textarea'
      end
    end

    scenario 'edit his answer with errors' #, js:true
    scenario "tries to edit other user's answer" #, js:true
  end
end
