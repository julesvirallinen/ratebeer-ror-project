require 'rails_helper'

include Helpers

describe "Ratings" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username: "Jani" }


  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, are registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect {
      click_button "Create Rating"
    }.to change { Rating.count }.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  describe "on ratings page" do
    it "ratings and amount of rating are listed" do
      create_ratings(user, beer1, 10, 11)
      create_ratings(user, beer2, 15)
      visit ratings_path

      expect(page).to have_content 'Number of ratings: 3'
      expect(page).to have_content 'iso 3: 10'
      expect(page).to have_content 'iso 3: 11'
      expect(page).to have_content 'Karhu: 15'
    end
  end
  describe "on user page" do
    before :each do
      create_ratings(user, beer1, 10)
    end
    it "is only listed if it is made by user" do
      sign_in(username: "Jani", password: "Foobar1")
      create_ratings(user2, beer2, 15, 5)

      visit user_path(user2)

      expect(page).to have_content 'Has 2 ratings, average 10'
      expect(page).to have_content 'Karhu: 15'
      expect(page).to have_content 'Karhu: 5'
      expect(page).not_to have_content 'iso 3: 10'

    end

    it "is not listed on users page when deleted" do
      visit user_path(user)
      within("li") do
        click_on("delete")
      end

      expect(page).not_to have_content 'iso 3: 10'
      expect(Rating.count).to eq(0)
    end
  end


  def create_ratings(user, beer, *scores)
    scores.each do |score|
      rating = FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    end
  end


end