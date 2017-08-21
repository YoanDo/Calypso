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
end
