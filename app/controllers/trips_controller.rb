class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_trip, only: [:show, :edit, :update, :private_session, :cancel]

  def index
    @date = params["date"] ? Date.strptime(params["date"], "%m/%d/%Y") : Date.today
    if params["nearfrom"]
      @trips = Location.where(direction: "from").near(params["nearfrom"],40).map(&:trip)
      @nb_result = @trips.count
    else
      @trips = Trip.all.map
      @nb_result = @trips.count
    end
    @trips_day = @trips.find_all { |t|  t.starts_at >= @date}.sort_by{|e| e[:starts_at]}.group_by { |t| t.starts_at.to_date }
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments.order(created_at: :desc)
    @participant = Participant.new
    @remaining_spots = (@trip.nb_participant - @trip.participants.select{ |p| p.status == 'accepted' }.size)

    if @trip.to.latitude.present?
      @spots = Spot.near(@trip.to.address, 20)
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

  def cancel
    unless @trip.user == current_user
      redirect_to trip_path(@trip)
    end
    @trip.status = 'cancelled'
    redirect_to root_path
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :starts_at, :ends_at, :description, :nb_participant, :category, :car)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
