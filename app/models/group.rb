class Group < ApplicationRecord
    belongs_to :post
    has_many :users, through: :group_users
    has_many :group_chats
end