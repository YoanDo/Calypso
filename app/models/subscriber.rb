class Subscriber < ApplicationRecord
  validates_format_of :email,:with => Devise::email_regexp
  validates :email, presence: :true
  validates :email, uniqueness: :true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :subscribe_user_to_mailing_list

  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(self)
  end
end
