STATUS = ["pending", "waiting list", "accepted", "cancelled", "declined"]


class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  validates :trip, uniqueness: { scope: :user, message: "You have already join the trip" }
  validates :status, inclusion: { in: STATUS }
  validates :message, presence: { message: "Please add a message" }

  def waiting_list
    self.status = "waiting list"
  end
end
