require 'rails_helper'

feature 'User can create answer on question page', %q{
  In order to help the user solve his problem
  As an authinticated user
  I'd like to be able to add answer
} do

  given!(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }



  describe 'Authinticated user' do
    given(:user) { create(:user) }

    background { sign_in(user) }

    background { visit question_path(question) }

    scenario 'add answer' do
      fill_in 'answer[body]', with: 'Some Body'
      click_on 'Add Answer'

      expect(page).to have_content 'Your answer successfully added.'
      expect(page).to have_content 'Some Body'
    end

    scenario 'add answer with errors' do
      click_on 'Add Answer'

      expect(page).to have_content "Answer body can't be blank"
    end
  end

  scenario 'Unauthinticated user tries to ask a question' do
    visit question_path(question)
    click_on 'Add Answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end




  # given!(:question) { create(:question) }
  # given!(:answers) { create_list(:answer, 3, question: question) }

  # background { visit question_path(question) }

  # scenario 'User add answer' do
    # fill_in 'answer[body]', with: 'Some Body'
    # click_on 'Add Answer'

    # expect(page).to have_content 'Your answer successfully added.'
    # expect(page).to have_content 'Some Body'
  # end

  # scenario "User add answer with errors" do
  #   fill_in 'answer[body]', with: ''
  #   click_on 'Add Answer'

  #   expect(page).to have_content "Answer body can't be blank"
  # end
end
