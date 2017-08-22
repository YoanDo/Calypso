class CommentsController < ApplicationController
  before_action :set_trip , only: [ :create ]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.trip = @trip
    if @comment.save
      redirect_to trip_path(@trip)
    else
      render "trips/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end
end
