class Message < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  validates :content, presence: :true, uniqueness: true
end
