class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_trip_#{params[:trip_id]}"
  end
end
