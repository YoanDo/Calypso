class CommentsController < ApplicationController
  before_action :set_trip , only: [ :create ]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.trip = @trip
    if @comment.save
      ActionCable.server.broadcast "comments_trip_#{@trip.id}",
        comment: (render(:partial => 'comments/show', :formats => [:html], :locals => { comment: @comment }))
      head :ok
    else
      respond_to do |format|
        format.html { render "trips/show" }
        format.js
      end
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


