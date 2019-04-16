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

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end
end
