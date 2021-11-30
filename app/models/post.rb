class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one :group, dependent: :nullify
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    # has_many :tags
end