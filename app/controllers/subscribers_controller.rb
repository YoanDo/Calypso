class SubscribersController < ApplicationController

  def create
    @subscriber = Subscriber.new(params[:subscriber])
    @subscriber.save
    redirect_to root_path
  end

end
