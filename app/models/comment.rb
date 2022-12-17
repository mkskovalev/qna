class Comment < ApplicationRecord
  searchkick

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  def search_data
    attrs = attributes.dup
    relational = {
      author_email: user.email,
    }
    attrs.merge! relational
  end
end
