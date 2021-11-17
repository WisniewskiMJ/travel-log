class WeatherGetter < ApplicationService
  def initialize(entry)
    @entry = entry
  end

  def call
    latitude = @entry.latitude
    longitude = @entry.longitude
    temperature = get_temperature(latitude, longitude)
    if temperature    
      @entry.update(temperature: temperature)
      result = OpenStruct.new({ successfull?: true, payload: @entry })
    else
      @entry.errors.add :base, message: 'No weather report for given location'
      result = OpenStruct.new({ successfull?: false, payload: @entry })
    end
  end

  private

  def get_temperature(latitude, longitude)
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&units=metric&appid=#{ENV['OPEN_WEATHER_MAP_API_KEY']}")
    return temperature = response["main"]["temp"].round if response["cod"] == 200
    nil
  end

end