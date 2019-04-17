class Driver < ApplicationRecord
  has_many :trips
  validates :name, :vin, presence: true

  def average_rating
    rated_trips = 0.0
    total_rating = 0.0
    trips.each do |trip|
      if trip.rating
        total_rating += trip.rating
        rated_trips += 1
      end
    end
    (total_rating / rated_trips).to_f.round(2)
  end
end
