class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_trip, only: [:show, :edit, :update, :private_session]

  def index
    @trips = Trip.search(params[:search])
    @trips_day = @trips.order(starts_at: :asc).group_by { |t| t.starts_at.to_date }
    @trips_map = @trips.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@trips_map) do |trip, marker|
      marker.lat trip.latitude
      marker.lng trip.longitude
    end
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments.order(created_at: :desc)
    @participant = Participant.new
    @remaining_spots = (@trip.nb_participant - @trip.participants.select{ |p| p.status == 'accepted' }.size)
    if @trip.latitude.present?
      @hash = Gmaps4rails.build_markers([@trip]) do |trip, marker|
        marker.lat trip.latitude
        marker.lng trip.longitude
      end
    end
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

  def private_session
    unless @trip.has_participant(current_user)[:status] == 'accepted'
      redirect_to trip_path(@trip)
    end
    @message = Message.new
    @messages = @trip.messages.order(created_at: :desc)
    @remaining_spots = (@trip.nb_participant - @trip.participants.select{ |p| p.status == 'accepted' }.size)
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :from, :to, :starts_at, :ends_at, :description, :nb_participant, :category, :car, :house, :equipment)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
