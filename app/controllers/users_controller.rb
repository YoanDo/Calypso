class UsersController < ApplicationController

  def mytrips
    @trips = current_user.trips
  end

  def mybookings
    @participants = current_user.participants
  end
end
