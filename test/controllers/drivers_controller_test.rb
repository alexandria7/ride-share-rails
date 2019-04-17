require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "Mr. Goodbar", vin: "8594832094857758"
  }

  describe "index" do
    it "can get to the index path" do
      get drivers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid driver" do
      get driver_path(driver.id)

      must_respond_with :success
    end

    it "will redirect for an invalid driver" do
      get driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can edit page for an existing driver" do
      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistent driver" do
      get edit_driver_path("#chicken")

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing driver" do
      driver_change = {
        driver: {
          name: "Lionel Tiger Bearington",
          vin: "3141591415926535",
        },
      }

      patch driver_path(driver.id), params: driver_change

      edited_driver = Driver.find_by(id: driver.id)
      expect(edited_driver.name).must_equal driver_change[:driver][:name]
      expect(edited_driver.vin).must_equal driver_change[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)
    end

    it "will redirect to the driver index page if given an invalid id" do
      invalid_driver_id = -1
      patch driver_path(invalid_driver_id)
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "new" do
    it "can get the new driver page" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver" do
      driver_hash = {
        driver: {
          name: "Dinnerplate Marconi",
          vin: "2091422091619719432",
        },
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end
  end

  describe "destroy" do

    it "can delete a driver" do
      new_driver = Driver.create(name: "Arya Stark", vin: "914433403888234")

      expect {
        delete driver_path(new_driver.id)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end