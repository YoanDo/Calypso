STATUS = ["pending", "going", "cancelled"]


class Trip < ApplicationRecord
  belongs_to :user

  has_many :participants, :dependent => :destroy
  has_many :comments, :dependent => :destroy


  validates :title, presence: :true, uniqueness: true
  validates :from, presence: :true
  validates :to, presence: :true
  validates :starts_at, presence: :true
  validates :ends_at, presence: :true
  validates :description, presence: :true
  validates :nb_participant, presence: :true
  validates :status, inclusion: { in: STATUS }

  def is_full?
    self.participants.where(status: "accepted").count >= self.nb_participant
  end

  def pending_to_waiting_list
    self.participants.where(status: "pending").each { |participant| participant.waiting_list }
  end
end
