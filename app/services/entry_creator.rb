class EntryCreator < ApplicationService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    entry = @user.entries.build(@params)
    if entry.valid?
      geocode = EntryGeocoder.call(entry)
      if geocode.successfull?
        entry = geocode.payload
        get_temperature = EntryTemperatureSetter.call(entry)
        if get_temperature.successfull?
          entry = get_temperature.payload
          entry.save
          OpenStruct.new({created?: true, payload: entry})
        else
          OpenStruct.new({created?: false, payload: entry})
        end
      else
        OpenStruct.new({created?: false, payload: entry})
      end
    else
      OpenStruct.new({created?: false, payload: entry})
    end
  end
end
