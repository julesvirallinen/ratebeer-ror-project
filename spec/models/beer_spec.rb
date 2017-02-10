require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with name and valid style" do
    beer = Beer.create name:"Koff", style:"IPA"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"nostyle"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end



end
