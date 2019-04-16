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
          phone_num: "this is a new description!",
        },
      }

      patch passenger_path(passenger.id), params: passenger_change

      edited_passenger = Passenger.find_by(id: passenger.id)
      expect(edited_passenger.name).must_equal passenger_change[:passenger][:name]
      expect(edited_passenger.phone_num).must_equal passenger_change[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger.id)
    end

    it "will redirect to the passenger index page if given an invalid id" do
      invalid_passenger_id = -1
      patch passenger_path(invalid_passenger_id)
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      # Act
      get new_passenger_path

      # Assert
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
