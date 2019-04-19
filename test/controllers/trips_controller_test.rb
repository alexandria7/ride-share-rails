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

      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.last
      expect(new_trip).wont_be_nil

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "should get to edit page" do
      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "should respond with a 404 if trip doesn't exist" do
      get edit_trip_path(-2)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "should update existing trip" do
      starter_input = {
        passenger_id: Passenger.create(name: "sdfghj", phone_num: "34567").id,
        driver_id: Driver.create(name: "dfvgbnm", vin: "345678i").id,
        date: "4/22/19",
        cost: 1700,
        rating: 3,
      }

      trip_to_update = Trip.create(starter_input)

      trip_hash = {
        "trip": {passenger_id: Passenger.create(name: "new", phone_num: "idk").id,
                 driver_id: Driver.create(name: "bye", vin: "23456ui").id,
                 date: "4/22/19",
                 cost: 1500,
                 rating: 4},
      }

      expect {
        patch trip_path(trip_to_update.id), params: trip_hash
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "can delete a trip" do
      trip1 = trip
      expect {
        delete trip_path(trip1.id)
      }.must_change "Trip.count", -1

      must_respond_with :redirect
    end

    it "should respond with a 404 if trip is not found" do
      expect {
        delete trip_path("fish")
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end
end
