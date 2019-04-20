require 'date'
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
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
    end
  end

  def new
    @trip = Trip.new
  end

  # def create
  #   @trip = Trip.new(
  #     date: Date.today,
  #     cost: nil,
  #     passenger_id: params[:passenger_id],
  #     driver_id: Driver.next_available.id,
  #     rating: nil
  #   )

  #   if @trip.save
  #     @trip.driver.update_attribute(:available, false)
  #     redirect_to trip_path(@trip)
  #   else
  #     redirect_to passenger_path(:passenger_id), status: :bad_request
  #   end
  # end

#   def new
# @trip = Trip.new
#   end

#   def create
#     @trip = Trip.new(trip_params)
#     if @trip.save
#       redirect_to trips_path
#     else
#       render :new
#     end
#   end

def create
  @trip = Trip.new(
    date: Date.today,
    cost: 1,
    passenger_id: params[:passenger_id],
    driver_id: Driver.next_available.id
  )

  if @trip.save
    @trip.driver.update_attribute(:available, false)
    redirect_to trip_path(@trip)
  else
    redirect_to passenger_path(params[:passenger_id]), available: :bad_request
  end
end

    # passenger_id = params[:passenger_id]
    # @passenger = Passenger.find_by(id: passenger_id)
    # driver = Driver.next_available
    # if @passenger && driver
    #   trip_hash = {
    #     passenger_id: passenger_id,
    #     driver_id: driver.id,
    #     date: Date.today.to_s,
    #     cost: 5,
    #   }
    #   trip = Trip.new(trip_hash)
    #   driver.available = false
    #   if driver.save && trip.save
    #     flash[:success] = "Your driver is: #{driver.name}. Have a lovely ride."
    #   else
    #     flash[:error] = "Not connecting to driver, please try again."
    #   end
    #   redirect_to passenger_path(passenger_id)
    # elsif !driver && @passenger
    #   flash[:error] = "Not connecting to driver, please try again."
    #   redirect_to passenger_path(passenger_id)
    # else
    #   head :not_found
    # end
  # end

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
    params.require(:trip).permit(:rating)
  end
end
