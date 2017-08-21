class ParticipantsController < ApplicationController
  before_action :set_trip , only: [ :create ]
  before_action :set_participant , only: [ :update ]

  def create
    @participant = Participant.new(participant_params)
    @participant.status = "pending"
    @participant.user = current_user
    @participant.trip = @trip
    if @participant.save
      redirect_to trip_path(@trip.id)
    else
      render :new
    end
  end

  def update
    @participant.update(participant_params)
    @participant.save
  end

  private

  def participant_params
    params.require(:participant).permit(:message, :status, :trip_id)
  end

  def set_trip()
    @trip = Trip.find(params[:trip_id])
  end

  def set_participant()
    @participant = Participant.find(params[:id])
  end


end
