class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one :group, dependent: :destroy
    # has_many :tags
end