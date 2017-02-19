class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city) { fetch_places_in(city) }
  end

  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch(city + "weather") { fetch_weather_in(city) }
  end


  private
  def self.fetch_weather_in(city)
    url = "http://api.apixu.com/v1/current.json?key=#{weatherkey}&q=#{ERB::Util.url_encode(city)}"
    return HTTParty.get url
    weather[:icon] = response["current"]["condition"]["icon"]
    weather[:c] = response["current"]["temp_c"]
    weather[:feels] = response["feelslike_c"]

  end

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.key
    raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end

  def self.weatherkey
    raise "APIKEY env variable not defined" if ENV['WEATHER'].nil?
    ENV['WEATHER']
  end

end
