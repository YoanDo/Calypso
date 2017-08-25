class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_trip, only: [:show, :edit, :update]

  def index
    if params["nearfrom"]
      @tripsloc = Location.where(direction: "from").near(params["nearfrom"],40).map(&:trip)
      @trips = @tripsloc.find_all { |t|  t.ends_at >= Date.today}.sort_by{|e| e[:starts_at]}
    else
      @trips = Trip.where('ends_at >= ?', Date.today).order(starts_at: :asc)
    end
    @trips_day = @trips.group_by { |t| t.starts_at.to_date }
    @hash = Gmaps4rails.build_markers(@trips) do |trip, marker|
      marker.lat trip.from.latitude
      marker.lng trip.from.longitude
    end
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments.order(created_at: :desc)
    @participant = Participant.new
    @remaining_spots = (@trip.nb_participant - @trip.participants.select{ |p| p.status == 'accepted' }.size)
    if @trip.to.latitude.present?
      @spots = Spot.near(@trip.to.address, 50)
      @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
        marker.lat spot.latitude
        marker.lng spot.longitude
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
      Location.create(address:params[:trip][:to], direction: "to", trip: @trip)
      Location.create(address:params[:trip][:from], direction: "from", trip: @trip)
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      @trip.to.address = params[:trip][:to]
      @trip.to.save
      @trip.from.address = params[:trip][:from]
      @trip.from.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :starts_at, :ends_at, :description, :nb_participant, :category, :car)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
