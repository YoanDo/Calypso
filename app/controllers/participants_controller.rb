class ParticipantsController < ApplicationController
  before_action :set_trip , only: [ :create ]
  before_action :set_participant , only: [ :update, :cancel ]
  # before_action :set_participant , only: [ :update, :cancel ]

  def create
    @participant = Participant.new(participant_params)
    @participant.user = current_user
    @participant.trip = @trip
    @trip.is_full? ? @participant.status = "waiting list" : @participant.status = "pending"
    if @participant.save
      redirect_to trip_path(@trip)
    else
      @comment = Comment.new
      @comments = @trip.comments
      @remaining_spots = (@trip.nb_participant - @trip.participants.select{ |p| p.status == 'accepted' }.size)
      render "trips/show"

    end
  end

  def update
    @participant.update(status:params[:status])
    @trip = Trip.find(@participant.trip.id)
    if @trip.is_full?
      @trip.pending_to_waiting_list
    end
    redirect_to :back
  end

  private

  def participant_params
    params.require(:participant).permit(:id, :message, :status, :trip_id)
  end

  def set_trip()
    @trip = Trip.find(params[:trip_id])
  end

  def set_participant()
    @participant = Participant.find(params[:id])
  end
end
