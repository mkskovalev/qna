require 'rails_helper'

feature 'User can add reward to question', %q{
  In order to give reward for best answer
  As an author
  I'd like to be able to add reward
} do

  given(:user) { create(:user) }

  scenario 'User adds reward when ask question', js:true do
    sign_in(user)
    visit new_question_path

    within '.question' do
      fill_in 'Title', with: 'some title'
      fill_in 'Body', with: 'some text'
    end

    within '.reward' do
      attach_file 'Image', "#{Rails.root}/spec/support/assets/test-image.png"
      fill_in 'Title', with: 'reward name'
    end

    click_on 'Ask'

    within '.new-answer' do
      fill_in 'answer[body]', with: 'Some Body'
      click_on 'Add Answer'
    end

    click_on 'Mark as Best'

    within '.reward' do
      expect(page).to have_css("img[src*='test-image.png']")
      expect(page).to have_content 'reward name'
    end

  end
end
