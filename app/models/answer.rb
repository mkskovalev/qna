class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author,
             class_name: 'User',
             foreign_key: 'user_id'

  has_many_attached :files

  validates :author, presence: true
  validates :body, presence: true,
                   uniqueness: { scope: :question_id, case_sensitive: false }
end
