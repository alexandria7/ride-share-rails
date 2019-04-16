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

  def new; end

  def create; end

  def destroy; end
end
