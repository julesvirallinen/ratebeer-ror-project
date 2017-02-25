class WeatherService
  def self.weather_for(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q=#{city}"
    response = HTTParty.get(url)
    return nil if response.code != 200 or response.parsed_response['error'] and response.parsed_response['error'].any?
    Weather.new response.parsed_response
  end

  private

  def self.key
    raise "APIKEY env variable not defined" if ENV['WEATHER'].nil?
    ENV['WEATHER']
  end

end