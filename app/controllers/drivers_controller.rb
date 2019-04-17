class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:name)
  end

  def show
    @driver = Driver.find_by(id: params[:id])
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    redirect_to driver_path(@driver) if @driver.update(driver_params)
  end

  def new
    @driver = Driver.new
  end

  def create
    driver = Driver.new(driver_params)

    if driver.save
      redirect_to driver_path(driver.id)
    else
      render :new
    end
  end

  def destroy; end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
