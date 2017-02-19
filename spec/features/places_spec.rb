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
  visit places_path
  fill_in('city', with: 'kumpula')
  click_button "Search"
end
