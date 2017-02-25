require 'beermapping_api'

class PlacesController < ApplicationController

  def index
  end

  def search
    session[:lastsearch] = params[:city]
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherService.weather_for(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingApi.places_in(session[:lastsearch]).select { |place| place.id == params[:id] }.first
    @map = "https://www.google.com/maps/embed/v1/place?key=#{ENV['MAPAPI']}&q=#{ERB::Util.url_encode(@place.name)},#{ERB::Util.url_encode(@place.city)}"
  end
end