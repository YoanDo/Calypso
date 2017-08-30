class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_trip, only: [:show, :edit, :update, :private_session, :cancel]

  def index
    @date = params["date"] ? Date.strptime(params["date"], "%m/%d/%Y") : Date.today

    if params["nearfrom"].presence
      trip_ids = Location.where(direction: "from").near(params["nearfrom"],40).map(&:trip_id)
      @trips = Trip.where(id: trip_ids)
    else
      @trips = Trip.all
    end

    if params['category'].presence
      @trips = @trips.where(category: params['category'])
    end

    @trips_day = @trips.find_all { |t|  t.starts_at >= @date}.sort_by{|e| e[:starts_at]}.group_by { |t| t.starts_at.to_date }
    @nb_result = @trips_day.count

    @filters = {
      date: @date.strftime("%m/%d/%Y"),
      category: params[:category],
      nearfrom: params[:nearfrom]
    }
  end

  def show
    @comment = Comment.new
    @comments = @trip.comments.order(created_at: :asc)
    @participant = Participant.new
    @remaining_spots = (@trip.nb_participant - @trip.participants.select{ |p| p.status == 'accepted' }.size)
    if @trip.to.latitude.present?
      @spots = Spot.near(@trip.to.address, 10)
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
      @trip.reload
      @trip.calcul_itinary
      @trip.save

      # send Facebook messenger notifification
      if ENV["ACCESS_TOKEN"].present?
        User.near(@trip.from.address, 40).each do |user|
          if (user.recipient_id?) && (user != current_user)
            Bot.deliver({
              recipient: {
                id: user.recipient_id
              },
              message:{
                attachment:{
                  type:"template",
                  payload:{
                    template_type:"button",
                    text:"Hey #{user.first_name}! #{@trip.user.first_name} has created a #{@trip.category}-trip to #{@trip.to.address}, leaving on #{@trip.starts_at.strftime("%m/%d")} with #{@trip.nb_participant} seats available ",
                    buttons:[
                      { type: 'web_url', title: 'More info', url: "http://www.calypso.surf#{trip_path(@trip)}" },
                      { type: 'postback', title: "Send booking request", payload: {trip_id: @trip.id, user_id: user.id}.to_json }
                    ]
                  }
                }
              }
            }, access_token: ENV['ACCESS_TOKEN'])
          end
        end
      end

      redirect_to root_path #change for back to show
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
      @trip.save
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

