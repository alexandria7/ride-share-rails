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

  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      passenger_hash = {
        passenger: {
          name: "new name",
          phone_num: "new phone number",
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "will return a 400 with an invalid passenger" do
      test_input = {
        "passenger": {
          name: "",
          phone_num: "415-666-0000",
        },
      }

      expect {
        post passengers_path, params: test_input
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "can edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistent passenger" do
      get edit_passenger_path("this is not a real id")

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing passenger" do
      passenger_change = {
        passenger: {
          name: "this is an updated name!",
          phone_num: "this is a new phone number!",
        },
      }

      patch passenger_path(passenger.id), params: passenger_change

      edited_passenger = Passenger.find_by(id: passenger.id)
      expect(edited_passenger.name).must_equal passenger_change[:passenger][:name]
      expect(edited_passenger.phone_num).must_equal passenger_change[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger.id)
    end

    it "will return a bad_request (400) when asked to update with invalid data" do
      starter_input = {
        name: "Sarah McCarthy",
        phone_num: "415-000-0002",
      }

      passenger_to_update = Passenger.create(starter_input)

      test_input = {
        "passenger": {
          name: "",
          phone_num: "415-000-0002",
        },
      }

      expect {
        patch passenger_path(passenger_to_update.id), params: test_input
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
      passenger_to_update.reload
      expect(passenger_to_update.name).must_equal starter_input[:name]
      expect(passenger_to_update.phone_num).must_equal starter_input[:phone_num]
    end
  end

  describe "destroy" do
    it "returns a 404 error if a passenger is not found" do
      invalid_passenger_id = -1

      expect {
        delete passenger_path(invalid_passenger_id)
      }.must_change "Passenger.count", 0

      must_respond_with :not_found
    end

    it "can delete a passenger" do
      new_passenger = Passenger.create(name: "Delete this task", phone_num: "415-000-000")

      expect {
        delete passenger_path(new_passenger.id)
      }.must_change "Passenger.count", -1

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
