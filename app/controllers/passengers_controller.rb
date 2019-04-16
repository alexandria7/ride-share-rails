class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    passenger = Passenger.new(passenger_params)

    if passenger.save
      redirect_to passenger_path(passenger.id)
    else
      render :new
    end
  end

  def edit
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to passengers_path
    end
  end

  def update
    passenger = Passenger.find_by(id: params[:id])

    if passenger.nil?
      redirect_to passengers_path
    else
      passenger.update(passenger_params)

      redirect_to passenger_path(passenger.id)
    end
  end

  def destroy
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
