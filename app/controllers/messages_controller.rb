class MessagesController < ApplicationController
  before_action :set_trip , only: [ :create ]

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.trip = @trip
    if @message.save
      ActionCable.server.broadcast "messages_trip_#{@trip.id}",
        message: (render(:partial => 'messages/show', :formats => [:html], :locals => { message: @message }))
      head :ok
    else
      respond_to do |format|
        format.html { render "trips/show" }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end
end
