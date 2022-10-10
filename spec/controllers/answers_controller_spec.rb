require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'save a new answer in the database' do
        expect { post :create, params: { answer: { body: 'Some Body', user_id: user }, question_id: question.id }, format: :js }.to change(Answer, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: { answer: { body: 'Some Body', user_id: user }, question_id: question.id, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id }, format: :js }.not_to change(Answer, :count)
      end

      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:answer) { create(:answer, question: question, user_id: user.id) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.not_to change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question, author: user) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer, question_id: question.id } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to question page' do
      delete :destroy, params: { id: answer, question_id: question.id }
      expect(response).to redirect_to question_path(answer.question)
    end
  end
end
