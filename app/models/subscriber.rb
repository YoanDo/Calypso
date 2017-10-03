class Subscriber < ApplicationRecord
  validates_format_of :email,:with => Devise::email_regexp
end
