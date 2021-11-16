class WeatherGetter < ApplicationService
  def initialize(entry)
    @entry = entry
    @city = entry.city
  end

  def call
    temperature = get_temperature
    if temperature    
      @entry.update(temperature: temperature)
      result = OpenStruct.new({ successfull?: true, payload: @entry })
    else
      @entry.errors.add :base, message: 'No weather report for given city'
      result = OpenStruct.new({ successfull?: false, payload: @entry })
    end
  end

  private

  def get_temperature
    city = Ascii.process(@city)
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&appid=#{ENV['OPEN_WEATHER_MAP_API_KEY']}")
    puts response
    temperature = response["main"]["temp"].round if response["cod"] == 200
  end

end