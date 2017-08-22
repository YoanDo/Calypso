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
    params.require(:user).permit(:description, :location, :language)

end
