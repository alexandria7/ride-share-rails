class DriversController < ApplicationController
  def index
    @drivers = Driver.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to drivers_path
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
    else
      render :edit, status: :bad_request
    end

    if @driver.nil?
      redirect_to drivers_path
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
    else
      driver.destroy
      redirect_to drivers_path
    end
  end

  def availability
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
    else
      driver.toggle(:available)
      driver.save
    end

    redirect_to driver_path(driver.id)
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :vin, :available, :active)
  end
end
