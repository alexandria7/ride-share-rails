require "test_helper"

describe TripsController do
  let (:trip) {
    Trip.create(
      driver_id: Driver.create(name: "sample name", vin: "12345678ABCDO").id,
      passenger_id: Passenger.create(name: "another name", phone_num: "415-555-5555").id,
      date: "12/24/19",
      cost: 0,
    )
  }

  describe "show" do
    it "can get a valid trip" do
      get trip_path(trip.id)
      must_respond_with :success
    end

    it "will show a 404 error for an invalid trip" do
      get trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip" do
      trip_hash = {
        trip: {
          passenger_id: Passenger.create(name: "hi", phone_num: "idk").id,
          driver_id: Driver.create(name: "bye", vin: "23456ui").id,
          date: "4/22/19",
          cost: 5,
        },
      }

      post create_passenger_trip_path, params: trip_hash

      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.last
      expect(new_trip).wont_be_nil

      must_respond_with :redirect
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
