require "test_helper"

describe TripsController do
  let (:trip) {
    Trip.create(driver_id: Driver.create(name: "sample name", vin: "12345678ABCDO").id,
                passenger_id: Passenger.create(name: "another name", phone_num: "415-555-5555"), date: DateTime.now.to_date)
  }
  # describe "index" do
  #   it "can get to the index path" do
  #     get trips_path

  #     must_respond_with :success
  #   end
  # end
  describe "show" do
    it "can get a valid trip" do
      valid_trip_id = trip.driver_id
      get trip_path(valid_trip_id)
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      get trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
