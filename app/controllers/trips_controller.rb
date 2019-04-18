class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      @trips = Trip.where(passenger: Passenger.find_by(id: [:passenger_id]))
    elsif params[:driver_id]
      @trips = Trip.where(driver: Driver.find_by(id: [:driver_id]))
    else
      @trips = Trip.all.order(:id)
    end
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
    end
  end

  def new
    # if params[:passenger_id]
    #   passenger = Passenger.find_by(id: params[:passenger_id])
    #   @trips = passenger.trips.new
    # end

    if params[:passenger_id]
      @trip = Trip.new(passenger_id: params[:passenger_id])
    end
  end

  def create
    @trip = Trip.create(passenger_id: Passenger.find_by(id: params[:passenger_id]).id, driver_id: Driver.find_by(availability: true).id, cost: 0, date: "Date.today")

    if @trip.nil?
      head :not_found
      # raise
    end
  end

  def edit
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
    else
      render :edit
    end

    if @trip.nil?
      head :not_found
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      head :not_found
    else
      trip.destroy
      redirect_to homepages_path
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
