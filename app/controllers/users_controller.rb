class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  def dashboard
  @trips = current_user.trips
  @participants = current_user.participants
  @user = current_user
    if @user.nil?
      redirect_to new_user_registration_path
    end
  end

  def mybookings
   @participants = current_user.participants
  end

  def mytrips
    @trips = current_user.trips
    @trips_day_past = @trips.where('ends_at <= ?', Date.today).order(starts_at: :asc).group_by { |t| t.starts_at.to_date }
    @trips_day_up = @trips.where('ends_at >= ?', Date.today).order(starts_at: :asc).group_by { |t| t.starts_at.to_date }


  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :level, :location, :language, :photo, :photo_cache)
  end
end
