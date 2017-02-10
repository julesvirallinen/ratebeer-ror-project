require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end
  it "is created when valid name is entered" do
    visit new_beer_path
    fill_in('beer[name]', with: 'Koff')

    expect {
      click_button "Create Beer"
    }.to change { Beer.count }.from(0).to(1)

  end

  it "is not created with invalid name" do
    visit new_beer_path
    fill_in('beer[name]', with: '')

      click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content 'Name can\'t be blank'

  end
end