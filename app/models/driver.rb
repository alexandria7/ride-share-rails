class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true 
  validates :vin, presence: true, uniqueness: true

  FEE = 165
  PERCENTAGE = 0.80

  def total_earnings
    return self.trips.sum { |trip| trip.cost - FEE } * PERCENTAGE
  end

  def average_rating
    not_nil = self.trips.find_all{ |trip| !trip.rating.nil? }
    return 1.0 * not_nil.sum{ |trip| trip.rating } / not_nil.length
  end
end
