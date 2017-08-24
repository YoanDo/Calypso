class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_trip_#{params[:trip_id]}"
  end
end

