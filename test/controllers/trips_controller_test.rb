require "test_helper"

describe TripsController do
  let (:trip) {
    Trip.create(
      driver_id: Driver.create(name: "sample name", vin: "12345678ABCDO").id,
      passenger_id: Passenger.create(name: "another name", phone_num: "415-555-5555").id,
      date: "12/24/19",
      rating: 5,
      cost: 0,
    )
  }

  describe "index" do
    # it "can get to the index path" do
    #   get trips_path

    #   must_respond_with :success
    # end
  end

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
