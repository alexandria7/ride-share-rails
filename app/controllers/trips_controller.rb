class TripsController < ApplicationController
  # def index
  #   if params[:passenger_id]
  #     @trips = Trip.where(passenger: Passenger.find_by(id: [:passenger_id]))
  #   elsif params[:driver_id]
  #     @trips = Trip.where(driver: Driver.find_by(id: [:driver_id]))
  #   else
  #     @trips = Trip.all.order(:id)
  #   end
  # end

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
    else
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new(
      passenger: Passenger.find_by(id: params[:trip][:passenger_id]),
      driver: Driver.find_by(available: true),
      date: Date.now.to_s,
      cost: 0,
      rating: 0,
    )

    if @trip.save
      flash[:success] = "Your driver is: #{driver.name}. Have a lovely ride."
      driver.available = false
      redirect_to trip_path(@trip.id)
    else
      flash[:error] = "Not connecting to driver, please try again."
      render :new
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
