require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/mkskovalev/3ecc7b933e298f450db34e5560eff6d4' }

  scenario 'User adds links when ask question' do
    sign_in(user)
    visit new_question_path

    within '.question' do
      fill_in 'Title', with: 'some title'
      fill_in 'Body', with: 'some text'
    end

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url

  end
end
