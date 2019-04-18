class DriversController < ApplicationController
  def index
    @drivers = Driver.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @driver = Driver.find_by(id: params[:id])
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def update
    driver = Driver.find_by(id: params[:id])
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

  def availability
    driver = Driver.find_by(id: params[:id])

    if !driver
      head :not_found
    else
      driver.toggle(:available)
      driver.save
    end

    redirect_to driver_path(driver.id)
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
