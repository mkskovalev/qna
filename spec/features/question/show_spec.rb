require 'rails_helper'

feature 'User can see all answers and create answer on question page', %q{
  In order to see all answers and add answer
  As an everyone
  I'd like to be able to see question, answers and add answer
} do

  given!(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  background { visit question_path(question) }

  scenario 'User sees question' do
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'User sees all the answers to the question' do
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  scenario 'User add answer' do
    fill_in 'answer[body]', with: 'Some Body'
    click_on 'Add Answer'

    expect(page).to have_content 'Your answer successfully added.'
    expect(page).to have_content 'Some Body'
  end

  scenario "User add answer with errors" do
    fill_in 'answer[body]', with: ''
    click_on 'Add Answer'

    expect(page).to have_content "Answer body can't be blank"
  end
end
