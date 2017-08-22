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
  
  def dashboard
  @trips = current_user.trips
  @participants = current_user.participants
  @user = current_user
    if @user.nil?
      redirect_to new_user_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :level, :location, :language, :photo, :photo_cache)
  end
end
