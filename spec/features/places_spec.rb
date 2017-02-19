require 'rails_helper'

describe "Places" do

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1)]
    )

    search_for_kumpula

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, they are all shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [Place.new(name: "Oljenkorsi", id: 1),
         Place.new(name: "Olotila", id: 2),
         Place.new(name: "Kaljala", id: 3)]
    )

    search_for_kumpula

    # save_and_open_page
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Olotila"
    expect(page).to have_content "Kaljala"


  end

  it "if none are returned by the API, the site informs of this" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        []
    )
    search_for_kumpula

    expect(page).to have_content "No locations in kumpula"
  end
end

def search_for_kumpula
  allow(BeermappingApi).to receive(:weather_in).with("kumpula").and_return(
      {"location"=>
           {"name"=>"Helsinki",
            "region"=>"Southern Finland",
            "country"=>"Finland",
            "lat"=>60.18,
            "lon"=>24.93,
            "tz_id"=>"Europe/Helsinki",
            "localtime_epoch"=>1487545523,
            "localtime"=>"2017-02-19 23:05"},
       "current"=>
           {"last_updated_epoch"=>1487545440,
            "last_updated"=>"2017-02-19 23:04",
            "temp_c"=>3.0,
            "temp_f"=>37.4,
            "is_day"=>0,
            "condition"=>{"text"=>"Partly cloudy", "icon"=>"//cdn.apixu.com/weather/64x64/night/116.png", "code"=>1003},
            "wind_mph"=>10.5,
            "wind_kph"=>16.9,
            "wind_degree"=>210,
            "wind_dir"=>"SSW",
            "pressure_mb"=>991.0,
            "pressure_in"=>29.7,
            "precip_mm"=>0.0,
            "precip_in"=>0.0,
            "humidity"=>93,
            "cloud"=>0,
            "feelslike_c"=>-1.0,
            "feelslike_f"=>30.2,
            "vis_km"=>10.0,
            "vis_miles"=>6.0}}

  )


  visit places_path
  fill_in('city', with: 'kumpula')
  click_button "Search"


end
