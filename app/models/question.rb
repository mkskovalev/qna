class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  belongs_to :author,
             class_name: 'User',
             foreign_key: 'user_id'

  belongs_to :best_answer,
             class_name: 'Answer',
             foreign_key: 'best_answer_id',
             optional: true

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :title, :body, :author, presence: true
end
