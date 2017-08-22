class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  def mytrips
    @trips = current_user.trips
  end

  def mybookings
    @participants = current_user.participants
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :level, :location, :language, :photo, :photo_cache)
  end
end
