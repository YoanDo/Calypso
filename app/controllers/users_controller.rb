class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    current_user.update(user_params)
    redirect_to user_path(@user)
  end

  def updatefbmessenger
    @user = current_user
    current_user.update(user_params)
    redirect_to trips_path, notice: 'Facebook notifications have been updated'
  end

  def mytrips
    @trips = current_user.trips.order(starts_at: :asc)
    @trips_up = @trips.find_all { |t|  t.starts_at >= Date.today }.group_by { |t| t.starts_at.to_date }
    @trips_past = @trips.find_all { |t|  t.starts_at <= Date.today }.group_by { |t| t.starts_at.to_date }

    @trips_booked = trip_booked(current_user)
    @trips_booked_up = @trips_booked.find_all { |t|  t[:trip].starts_at >= Date.today }.group_by { |t| t[:trip].starts_at.to_date }
    @trips_booked_past = @trips_booked.find_all { |t|  t[:trip].starts_at <= Date.today }.group_by { |t| t[:trip].starts_at.to_date }
  end

  def mymessages
    @user = current_user
    @trips = all_trips(@user)
    @first_trip = @trips.first
    @message = Message.new
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :description, :level, :location, :language, :photo, :photo_cache, :follow_city)
  end

  def trip_booked(user)
    trips = []
    user.participants.each do |participant|
      trips << { trip: participant.trip, status: participant.status }
    end
    return trips.sort_by {|t| t[:trip].starts_at }
  end

  def all_trips(user)
    trips = []

    user.trips.each do |trip|
      trips << trip
    end

    user.participants.each do |participant|
      if participant.status == 'accepted'
        trips << participant.trip
      end
    end

    return trips.sort_by {|trip| trip.starts_at }.reverse
  end
end
