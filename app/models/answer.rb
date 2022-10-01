class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true,
                   uniqueness: { scope: :question_id, case_sensitive: false }
end
