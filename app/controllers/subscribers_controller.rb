class SubscribersController < ApplicationController
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  skip_before_action :authenticate_user!

  after_create :subscribe_user_to_mailing_list


  def create
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.save
    redirect_to root_path
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(self)
  end

end
