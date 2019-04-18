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

    it "will return a 400 with an invalid driver" do
      test_input = {
        "driver": {
          name: "",
          vin: "1234567890340987",
        },
      }

      expect {
        post drivers_path, params: test_input
      }.wont_change "Driver.count"

      must_respond_with :bad_request
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

    it "will return a bad_request (400) when asked to update with invalid data" do
      starter_input = {
        name: "Sara Kivikas",
        vin: "ABC123GNHJT6789",
      }

      driver_to_update = Driver.create(starter_input)

      test_input = {
        "driver": {
          name: "",
          vin: "ABC123GNHJT6789",
        },
      }

      expect {
        patch driver_path(driver_to_update.id), params: test_input
      }.wont_change "Driver.count"

      must_respond_with :bad_request
      driver_to_update.reload
      expect(driver_to_update.name).must_equal starter_input[:name]
      expect(driver_to_update.vin).must_equal starter_input[:vin]
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

    it "returns a 404 error if a driver is not found" do
      invalid_driver_id = "cashew"

      expect {
        delete driver_path(invalid_driver_id)
      }.must_change "Driver.count", 0

      must_respond_with :not_found
    end
  end
end
