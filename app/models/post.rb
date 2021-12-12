class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one :group, dependent: :nullify
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    # has_many :tags

    validate :low_le_high, :start_le_end, :end_validate

    def low_le_high
        if low_number > high_number
            errors.add(:at_least_people, "cannot be greater than At most people")
        end
    end

    def start_le_end
        if self.start > self.end
            errors.add(:start_date, "cannot be later than End date")
        end
    end

    def end_validate
        if self.end < Date.today
            errors.add(:end_date, "cannot be prior to today")
        end
    end
end