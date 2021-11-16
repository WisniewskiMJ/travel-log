class EntryCreator < ApplicationService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    entry = @user.entries.build(@params)
    if entry.valid?
      get_temperature = WeatherGetter.call(entry)
      if get_temperature.successfull?
        entry = get_temperature.payload
        entry.save
        result = OpenStruct.new({ created?: true, payload: entry })
      else
        result = OpenStruct.new({ created?: false, payload: entry })
      end
    else
      result = OpenStruct.new({ created?: false, payload: entry })
    end
  end
end