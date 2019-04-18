class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end

  def show
    if params[:passenger_id]
      @trip = Trip.find_by(passenger: Passenger.find_by(id: params[:passenger_id]))
    elsif params[:driver_id]
      @trip = Trip.find_by(driver: Driver.find_by(id: params[:driver_id]))
    else 
      @trip = Trip.find_by(id: params[:id])
    end
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end
