class AddColumnBestAnswerToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :best_answer, foreign_key: { to_table: :answers }, null: true
  end
end
