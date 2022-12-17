require 'rails_helper'

feature 'User can searching', %q{
  In order to find question, answer, comment or user
  As a user
  I'd like to be able to do search
} do

  given!(:user) { create(:user, :reindex, email: 'test@mail.ru') }
  given!(:question) { create(:question, :reindex, title: 'Test Title', body: 'some body') }
  given!(:answer) { create(:answer, :reindex, body: 'some test answer', question: question) }
  given!(:comment) { create(:comment, :reindex, body: 'some test comment', commentable: question, user: user) }

  background { visit root_path }

  describe 'Search Everywhere' do
    scenario 'Gives right results with' do
      within '.search' do
        fill_in 'Search for', with: 'test'
        select 'Everywhere', from: :model
        click_on 'Search'
      end

      expect(page).to have_content 'Test Title'
      expect(page).to have_content 'some test answer'
      expect(page).to have_content 'test@mail.ru'
      expect(page).to have_content 'some test comment'
    end

    scenario 'Gives no results if models does not include query' do
      within '.search' do
        fill_in 'Search for', with: 'apple'
        select 'Everywhere', from: :model
        click_on 'Search'
      end

      expect(page).to have_content 'No questions searched for this query...'
      expect(page).to have_content 'No answers searched for this query...'
      expect(page).to have_content 'No users searched for this query...'
      expect(page).to have_content 'No comments searched for this query...'
    end
  end

  describe 'Search in Questions' do
    scenario 'Gives right results with' do
      within '.search' do
        fill_in 'Search for', with: 'test'
        select 'Questions', from: :model
        click_on 'Search'
      end

      expect(page).to have_content 'Test Title'
    end

    scenario 'Gives no results if models does not include query' do
      within '.search' do
        fill_in 'Search for', with: 'apple'
        select 'Questions', from: :model
        click_on 'Search'
      end

      expect(page).to have_content 'No results for this search...'
    end
  end

end
