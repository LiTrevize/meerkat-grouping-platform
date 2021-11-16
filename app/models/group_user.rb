class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  enum status: [:applied, :approved, :rejected, :accepted, :refused, :dismissed]
end