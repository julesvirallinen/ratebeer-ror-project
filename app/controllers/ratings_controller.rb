class RatingsController < ApplicationController
  before_action :skip_if_cached, only: [:index]


  def index
    @ratings = Rating.all
    @best_breweries = Rails.cache.fetch "brew top 3", expires_in: 1.hour { Brewery.top 3 }
    @best_beers = Rails.cache.fetch "beers top 3", expires_in: 1.hour { Beer.top 3 }
    @best_styles = Rails.cache.fetch "style top 3", expires_in: 1.hour { Style.top 3 }
    @top_raters = Rails.cache.fetch "user top 3", expires_in: 1.hour { User.top 3 }

    # @best_beers = Beer.top(3)
    # @best_breweries = Brewery.top(3)
    # @best_styles = Style.top(3)
    # @top_raters = User.top(3)
    # @ratings = Rating.all
  end




  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating ## virheen aiheuttanut rivi
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  private

  def skip_if_cached
    return render :index if request.format.html? and fragment_exist?('ratings')
  end
end
