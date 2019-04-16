class Passenger < ApplicationRecord
  has_many :trips

  def total_amount_charged
    passenger_trips = self.trips.all

    total_cost = 0

    passenger_trips.each do |trip|
      total_cost += trip.cost
    end

    return (total_cost.to_i / 100.0).round(2)
  end
end
