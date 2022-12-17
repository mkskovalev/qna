class Question < ApplicationRecord
  include Votable
  include Commentable

  searchkick

  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy

  belongs_to :author,
             class_name: 'User',
             foreign_key: 'user_id'

  belongs_to :best_answer,
             class_name: 'Answer',
             foreign_key: 'best_answer_id',
             optional: true

  has_many_attached :files, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, :author, presence: true

  scope :daily, -> { where('created_at > ? ', Time.now - 1.day) }

  after_create :calculate_reputation
  after_create :subscribe_author

  def search_data
    attrs = attributes.dup
    relational = {
      author_email: author.email,
    }
    attrs.merge! relational
  end

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end

  def subscribe_author
    Subscription.create(question_id: self.id, user_id: self.author.id)
  end
end
