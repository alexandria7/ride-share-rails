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
    driver = Driver.find(params[:id])
    if driver.update(driver_params)
      redirect_to drivers_path
    else
      render :edit, status: :bad_request
    end
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

  def destroy

  end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
