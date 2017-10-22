class SubscribersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.save
    redirect_to root_path
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

end
