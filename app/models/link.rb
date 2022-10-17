class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  validates :name, :url, presence: true
  validates :url, format: { with: /https:\/\/gist.github.com\/[A-Za-z0-9][A-Za-z0-9-]*\/[a-f\d]+/,
                            message: 'must be a link to a gist.' }
end
