class Subscriber < ApplicationRecord
  validates_format_of :email,:with => Devise::email_regexp
  validates :email, presence: :true
  validates :email, uniqueness: :true
end
