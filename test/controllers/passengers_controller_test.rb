require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample passenger", phone_num: "415-555-1001"
  }

  describe "index" do
    it "can get to the index path" do
      get passengers_path

      must_respond_with :success
    end 
  end

  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(passenger.id)

      must_respond_with :success
    end

    it "will redirect for an invalid passenger" do
      get passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
