class EntryGeocoder < ApplicationService
  def initialize(entry)
    @entry = entry
  end

  def call
    location = @entry.location
    location_geocode = Geocoder.search(location)
    geocode = location_filter(location_geocode)
    if geocode.length == 0
      @entry.errors.add :base, message: "Given location invalid"
      OpenStruct.new({successfull?: false, payload: @entry})
    elsif geocode.length > 1
      @entry.errors.add :base, message: "Multiple locations found. First few:"
      geocode.each do |g|
        @entry.errors.add :base, message: g.display_name
      end
      @entry.errors.add :base, message: "Provide more details or enter geographic coordinates"
      OpenStruct.new({successfull?: false, payload: @entry})
    else
      set_name(geocode.first.data)
      set_coordinates(geocode.first.data)
      OpenStruct.new({successfull?: true, payload: @entry})
    end
  end

  private

  def location_filter(location_geocode)
    distant = []
    location_geocode.each do |loc|
      distant << loc if distant.none? { |l| close?(loc, l) }
    end
    distant
  end

  def close?(location1, location2)
    (location1.data["lat"].to_f - location2.data["lat"].to_f > -0.1 && location1.data["lat"].to_f - location2.data["lat"].to_f < 0.1) &&
      (location1.data["lon"].to_f - location2.data["lon"].to_f > -0.1 && location1.data["lon"].to_f - location2.data["lon"].to_f < 0.1)
  end

  def set_name(location)
    @entry.location = if location["address"]["administrative"].present?
      location["address"]["administrative"]
    elsif location["address"]["city"].present?
      location["address"]["city"]
    elsif location["address"]["village"].present?
      location["address"]["village"]
    else
      "Anonymous location"
    end
  end

  def set_coordinates(location)
    @entry.latitude = location["lat"]
    @entry.longitude = location["lon"]
  end
end
