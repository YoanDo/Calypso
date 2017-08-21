class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  validates :trip, uniqueness: { scope: :user, message: "You have already join the trip" }
end
