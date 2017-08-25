class Location < ApplicationRecord
  belongs_to :trip

  validates :address, presence: :true

  geocoded_by :address
  after_validation :geocode, if: :address?

  def self.search(location)
    if location
      near("#{location}", 50)
    else
      all
    end
  end

  def nearof(location)
    if location
      list_location = Location.search("#{location}")
      list_location.include?(self)
    end
  end

end
