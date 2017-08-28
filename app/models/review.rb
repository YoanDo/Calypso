RATING = [1,2,3,4,5]


class Review < ApplicationRecord
  has_one :reviewee, :class_name => "User"
  has_one :reviewer, :class_name => "User"

  validates :rating, presence: :true, inclusion: { in: RATING }
  validates :comment, presence: :true
end
