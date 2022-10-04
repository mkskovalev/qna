require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from community
  As an everyone
  I'd like to be able to ask the question
} do

  background do
    visit questions_path
    click_on 'Ask Question'
  end

  scenario 'User ask a question' do
    fill_in 'Title', with: 'New Title'
    fill_in 'Body', with: 'Some text'
    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'New Title'
    expect(page).to have_content 'Some text'
  end

  scenario 'User ask a question with errors' do
    fill_in 'Title', with: 'New Title'
    click_on 'Ask'

    expect(page).to have_content "Body can't be blank"
  end
end
