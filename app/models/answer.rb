class Answer < ApplicationRecord
  include Votable
  include Commentable

  searchkick

  has_many :links, dependent: :destroy, as: :linkable
  belongs_to :question, touch: true
  belongs_to :author,
             class_name: 'User',
             foreign_key: 'user_id'

  has_many_attached :files, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :author, presence: true
  validates :body, presence: true,
                   uniqueness: { scope: :question_id, case_sensitive: false }

  after_create :send_notification

  def search_data
    attrs = attributes.dup
    relational = {
      author_email: author.email,
    }
    attrs.merge! relational
  end

  private

  def send_notification
    NewAnswerNotificationJob.perform_later(self)
  end
end
