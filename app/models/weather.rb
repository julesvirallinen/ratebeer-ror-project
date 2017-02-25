class Weather
  attr_accessor :city, :temp, :icon, :feels
  def initialize(hash)
    @city = hash['location']['name']
    @temp = hash['current']['temp_c']
    @icon = hash['current']['condition']['icon']
    @feels = hash['current']['feelslike_c']

  end
end