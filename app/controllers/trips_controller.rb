class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_trip, only: [:show, :edit, :update]

  def index
    @trips = Trip.all
    @trips_day = @trips.order(starts_at: :asc).group_by { |t| t.starts_at.to_date }
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments
    @participant = Participant.new
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :from, :to, :starts_at, :ends_at, :description, :nb_participant, :category, :car, :house, :equipment)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
