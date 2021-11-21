class PostTag < ApplicationRecord
    belongs_to :post
    belongs_to :tag, foreign_key: "tag_name", primary_key: "name"
end