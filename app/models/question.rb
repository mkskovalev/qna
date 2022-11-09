class Question < ApplicationRecord
  include Votable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy

  belongs_to :author,
             class_name: 'User',
             foreign_key: 'user_id'

  belongs_to :best_answer,
             class_name: 'Answer',
             foreign_key: 'best_answer_id',
             optional: true

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, :author, presence: true
end
